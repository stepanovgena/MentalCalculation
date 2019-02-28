//
//  GameViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 07/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet weak var aLabel: UILabel!
  @IBOutlet weak var bLabel: UILabel!
  @IBOutlet weak var responseLabel: UILabel!
  @IBOutlet weak var operationLabel: UILabel!
  @IBOutlet weak var equalsLabel: UILabel!
  @IBOutlet weak var zeroButton: RoundButton!
  @IBOutlet weak var oneButton: RoundButton!
  @IBOutlet weak var twoButton: RoundButton!
  @IBOutlet weak var threeButton: RoundButton!
  @IBOutlet weak var fourButton: RoundButton!
  @IBOutlet weak var fiveButton: RoundButton!
  @IBOutlet weak var sixButton: RoundButton!
  @IBOutlet weak var sevenButton: RoundButton!
  @IBOutlet weak var eightButton: RoundButton!
  @IBOutlet weak var nineButton: RoundButton!
  @IBOutlet weak var clearButton: RoundButton!
  @IBOutlet weak var enterButton: RoundButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var heartOne: UILabel!
  @IBOutlet weak var heartTwo: UILabel!
  @IBOutlet weak var heartThree: UILabel!
  @IBOutlet weak var pauseButton: UIButton!
  
  var gameCategory: GameCategory = .addition
  var gameLevel: Level = .easy
  var progressUpdateSpeed: Float = 0.001
  var limitedTimeToResolve = true
  var wrongTasksArray = [[String]]()
  private var responseString: String = String()
  lazy var operationsSign = gameCategory.sign
  private var score: Score = Score()
  private var lives: Int = 3
  private var scoreForSpeed: Int = 0
  var progress: Float  = 0.0
  var isGamePaused = false
  var fadedLabels: [UILabel] = []
  
  let presentTransition = CustomPresentModalAnimator()
  let dismissTransition = CustomDismissModalAnimator()
  
  lazy var roundButtons: [RoundButton] = [
  zeroButton,
  oneButton,
  twoButton,
  threeButton,
  fourButton,
  fiveButton,
  sixButton,
  sevenButton,
  eightButton,
  nineButton,
  clearButton,
  enterButton,
  ]
  
  lazy var heartLabels: [UILabel] = [
  heartOne,
  heartTwo,
  heartThree
  ]
  
  lazy var game: Game = Game(gameCategory: self.gameCategory, gameLevel: self.gameLevel)
  lazy var task: Solvable = game.generateTask(category: game.gameCategory, level: game.gameLevel)
  
  //don't like this instance member with exact parameters
  private var timer: Timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(t) in })
  
  //MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()    
    localizeStrings()
    applyColorScheme()
    
     let rotateView = CGAffineTransform(rotationAngle: CGFloat.pi)
     let scaleView = CGAffineTransform(scaleX: 1, y: 2)
    
    progressBar.transform = rotateView.concatenating(scaleView)
    
    //adjust timer speed according to difficulty
    switch gameLevel {
    case .easy: progressUpdateSpeed = 0.0005
    case .normal: progressUpdateSpeed = 0.001
    case .hard: progressUpdateSpeed = 0.0005
    }
    //listen for going to background, stop the timer, save progress
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(invalidateTimerAndSaveTopScore),
      name: UIApplication.willResignActiveNotification,
      object: nil)
    
    //listen for returning to foreground, start timer from saved progress
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateProgressBar),
      name: UIApplication.didBecomeActiveNotification,
      object: nil)
    
    for heartLabel in heartLabels {
      heartLabel.text = "\u{2764}"
    }
    
    updateViewFromModel()
    timer.invalidate()//otherwise updateProgressBar will not take effect
    updateProgressBar()
  }
  
  override func viewDidLayoutSubviews() {
    for button in roundButtons {
      button.refreshCornerRadius()
      button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
      button.titleLabel?.minimumScaleFactor = 0.5
      button.titleLabel?.adjustsFontSizeToFitWidth = true
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    updateProgressBar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    invalidateTimerAndSaveTopScore()
  }
  
  //MARK: Game events
  /**Draws current task, score and lives in UI */
  private func updateViewFromModel() {
    aLabel.text = String(task.a)
    bLabel.text = String(task.b)
    operationLabel.text = operationsSign
    scoreLabel.text = "\u{1F3C6}\(score.getScore())"
  }
  
  /**Generates new task of given category and difficulty */
  private func updateTask() {
    task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
  }
  
  /**The score is calculated as 10 * (task category * level difficulty + 0.5 * scoreForSpeed) */
  private func updateScore() {
    score.setScore(newValue: score.getScore() + 10 * (task.level.rawValue * (self.gameCategory.rawValue) +  scoreForSpeed/2))
  }
  
  /**Clears user input text*/
  private func clearResponseLabel() {
    responseString = ""
    responseLabel.text = " ?  "
  }
  
  /**Handles time given to respond to the task*/
  @objc func updateProgressBar() {
    
    if limitedTimeToResolve {
      
      progressBar.setProgress(progress, animated: false)
      
      if (!timer.isValid && !isGamePaused) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(t) in
          
          self.progress += self.progressUpdateSpeed
          self.progressBar.setProgress(self.progress, animated: true)
          
          //additional points for speed of answer
          self.scoreForSpeed = Int((1 - self.progress) * 10)
          
          if (self.progress > 0.8) {
            self.progressBar.trackTintColor = .red
          }
          
          //if timer runs out then stop timer and programmatically press Enter
          if (self.progress > 0.999) {
            t.invalidate()
            self.progress = 0.0
            self.enterButtonPressed(self.enterButton)
          }
        })
      }
    } else {
      progressBar.isHidden = true
    }
  }
  
  @objc func invalidateTimerAndSaveTopScore() {
    timer.invalidate()
    score.updateTopScore()
  }
  
  /**Adds wrong answered task to array to display when the game is over */
  private func addWrongTaskToList(task: Solvable, userResponse: String) {
    wrongTasksArray.append([String(task.a), operationsSign, String(task.b), userResponse, String(task.result)])
  }
  
  private func indicateSuccess() {
    let animation = CASpringAnimation(keyPath: "transform.scale")
    animation.fromValue = 0.8
    animation.toValue = 1
    animation.stiffness = 200
    animation.mass = 2
    animation.duration = 0.8
    animation.beginTime = CACurrentMediaTime()
    animation.fillMode = CAMediaTimingFillMode.backwards
    scoreLabel.layer.add(animation, forKey: nil)
  }
  
  private func indicateFailure() {
    guard lives > 0 else { return }
    let labelToAnimate = heartLabels[3 - lives]
    
    let fadedLabel = UILabel(frame: labelToAnimate.frame)
    fadedLabel.text = "\u{2764}"
    fadedLabel.alpha = 0.3
    view.addSubview(fadedLabel)
    fadedLabels.append(fadedLabel)
  
    UIView.animate(withDuration: 0.8, animations: {
      let translate = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
      let rotate = CGAffineTransform(rotationAngle: .pi)
      labelToAnimate.transform = rotate.concatenating(translate)
      
    }, completion: {(finished: Bool) in
      labelToAnimate.alpha = 0
    })
  }
  
  /**Needed to refresh state after PlayAgain is selected in GameOver VC */
  func refreshState() {
    score.setScore(newValue: 0)
    lives = 3
    updateViewFromModel()
    wrongTasksArray.removeAll()
    updateTask()
    clearResponseLabel()
    updateViewFromModel()
    for label in heartLabels {
      label.transform = .identity
      label.alpha = 1
    }
    for fadedLabel in fadedLabels {
      fadedLabel.removeFromSuperview()
    }
  }
  
  func applyColorScheme() {
    
    view.backgroundColor = ColorScheme.backgroundColor
    aLabel.textColor = ColorScheme.primaryFontColor
    bLabel.textColor = ColorScheme.primaryFontColor
    responseLabel.textColor = ColorScheme.primaryFontColor
    operationLabel.textColor = ColorScheme.primaryFontColor
    equalsLabel.textColor = ColorScheme.primaryFontColor
    scoreLabel.textColor = ColorScheme.primaryFontColor
    
    for button in roundButtons {
      button.backgroundColor = ColorScheme.primaryDigitButtonColor
    }
    
    clearButton.backgroundColor = ColorScheme.backgroundColor
    clearButton.setTitleColor(ColorScheme.secondaryCircularButtonTextColor, for: .normal)
    enterButton.backgroundColor = ColorScheme.backgroundColor
    enterButton.setTitleColor(ColorScheme.secondaryCircularButtonTextColor, for: .normal)
    clearButton.layer.borderColor = UIColor.lightGray.cgColor
    clearButton.layer.borderWidth = 1
    enterButton.layer.borderColor = UIColor.lightGray.cgColor
    enterButton.layer.borderWidth = 1
    
    progressBar.trackTintColor = ColorScheme.progressBarTrackColor
    progressBar.progressTintColor = ColorScheme.progressBarBackgroundColor
    pauseButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
  }
  
  func localizeStrings() {
  pauseButton.setTitle(NSLocalizedString("Pause Game", comment: "Press button to pause game"), for: .normal)
  clearButton.setTitle(NSLocalizedString("Clear", comment: "Press button to clear response"), for: .normal)
  enterButton.setTitle(NSLocalizedString("Enter", comment: "Press button to enter response"), for: .normal)
  }
  
  //MARK: IBActions
  @IBAction func digitButtonPressed(_ sender: UIButton) {
    guard  let buttonLabel = sender.titleLabel else { return }
    if let input = buttonLabel.text {
      responseString.append(input)
      responseLabel.text = responseString
    }
  }
  
  @IBAction func clearButtonPressed(_ sender: UIButton) {
    clearResponseLabel()
  }
  
  @IBAction func enterButtonPressed(_ sender: UIButton) {
    progress = 0.0
    progressBar.trackTintColor = ColorScheme.progressBarTrackColor
    if (String(task.result) == responseString) {
      timer.invalidate()
      indicateSuccess()
      updateScore()
      clearResponseLabel()
      updateTask()
      updateViewFromModel()
      updateProgressBar()
      
    } else {
      timer.invalidate()
      indicateFailure()
      if (responseString == "") {
        addWrongTaskToList(task: task, userResponse: "??")
      } else {
      addWrongTaskToList(task: task, userResponse: responseString)
      }
      lives -= 1
      if lives == 0 {
        score.updateTopScore()
        performSegue(withIdentifier: "gameOverSegue", sender: self)
        
      } else {
        clearResponseLabel()
        updateTask()
        updateViewFromModel()
        updateProgressBar()
      }
    }
  }
  
  @IBAction func pauseButtonPressed(_ sender: Any) {
    
    invalidateTimerAndSaveTopScore()
    //animate custom transition with blurred background
    isGamePaused = true
    let pauseGameViewController = storyboard?.instantiateViewController(withIdentifier: "pauseGameViewController") as! PauseGameViewController
    pauseGameViewController.transitioningDelegate = self
    present(pauseGameViewController, animated: true, completion: nil)
    //closure callback to dismiss modal VC
    pauseGameViewController.didClose = { [unowned pauseGameViewController] in
      pauseGameViewController.dismiss(animated: true, completion: nil)
    }
  }
  
  //MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? GameOverViewController {
      progressBar.setProgress(0, animated: false)
      destination.displayedScore = score.getScore()
      destination.wrongAnswersArray = wrongTasksArray
    }
  }
}

//MARK: Extensions
extension GameViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return presentTransition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dismissTransition
  }
}
