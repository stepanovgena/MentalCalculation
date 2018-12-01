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
  @IBOutlet weak var digitButton: UIButton!
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var enterButton: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var livesLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var gameCategory: GameCategory = .addition
  var gameLevel: Level = .easy
  var progressUpdateSpeed: Float = 0.001
  var limitedTimeToResolve = true
  var wrongTasksArray = [String]()
  private var responseString: String = String()
  lazy var operationsSign = gameCategory.sign
  private var score: Score = Score()
  private var lives: Int = 3
  private var scoreForSpeed: Int = 0
  var progress: Float  = 0.0
  
  lazy var game: Game = Game(gameCategory: self.gameCategory, gameLevel: self.gameLevel)
  lazy var task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
  
  //don't like this instance member with exact parameters
  private var timer: Timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(t) in })
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adjust timer speed according to difficulty
    switch gameLevel {
    case .easy: progressUpdateSpeed = 0.0005
    case .normal: progressUpdateSpeed = 0.001
    case .hard: progressUpdateSpeed = 0.0005
    }
    //listen for going to background, stop the timer, save progress
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(disableTimerAndSaveTopScore),
      name: UIApplication.willResignActiveNotification,
      object: nil)
    
    //listen for returning to foreground, start timer from saved progress
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateProgressBar),
      name: UIApplication.didBecomeActiveNotification,
      object: nil)
    
    updateViewFromModel()
    updateProgressBar()
    
  }
  
  /**Draws current task, score and lives in UI */
  func updateViewFromModel() {
    aLabel.text = String(task.a)
    bLabel.text = String(task.b)
    operationLabel.text = operationsSign
    scoreLabel.text = "\u{1F3C6}\(score.getScore())"
    livesLabel.text = "\u{2764}\(lives)"
  }
  
  /**Generates new task of given category and difficulty */
  func updateTask() {
    task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
  }
  
  /**The score is calculated as 10 * (task category * level difficulty + 0.5 * scoreForSpeed) */
  func updateScore() {
    score.setScore(newValue: score.getScore() + 10 * (task.level.rawValue * (self.gameCategory.rawValue) +  scoreForSpeed/2))
  }
  
  /**Clears user input text*/
  func clearResponseLabel() {
    responseString = ""
    responseLabel.text = " ?  "
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  @IBAction func digitButtonPressed(_ sender: UIButton) {
    responseString.append(sender.titleLabel!.text!)
    responseLabel.text = responseString
  }
  
  @IBAction func clearButtonPressed(_ sender: UIButton) {
    clearResponseLabel()
  }
  
  @IBAction func enterButtonPressed(_ sender: UIButton) {
    self.progress = 0.0
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
      addWrongTaskToList(task: task)
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
  
  /**Blinks green if the answer is correct*/
  func indicateSuccess() {
    UIView.animate(withDuration: 0.2, animations: {
      self.view.backgroundColor = UIColor.green
    }, completion: {(finished: Bool) in self.view.backgroundColor = UIColor.black})
  }
  
  /**Blinks red if the answer is correct*/
  func indicateFailure() {
    UIView.animate(withDuration: 0.2, animations: {
      self.view.backgroundColor = UIColor.red
    }, completion: {(finished: Bool) in self.view.backgroundColor = UIColor.black})
  }
  
  /**Handles time given to respond to the task*/
  @objc func updateProgressBar() {
    
    if limitedTimeToResolve {
      progressBar.setProgress(progress, animated: false)
      progressBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
      timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(t) in
        
        self.progress += self.progressUpdateSpeed
        self.progressBar.setProgress(self.progress, animated: true)
        
        //additional points for speed of answer
        self.scoreForSpeed = Int((1 - self.progress) * 10)
        
        //if timer runs out then stop timer and programmatically press Enter
        if (self.progress > 0.999) {
          t.invalidate()
          self.progress = 0.0
          self.enterButtonPressed(self.enterButton)
        }
      })
    } else {
      progressBar.isHidden = true
    }
  }
  
  @objc func disableTimerAndSaveTopScore() {
    timer.invalidate()
    score.updateTopScore()
  }
  /**Adds wrong answered task to array to display when the game is over */
  func addWrongTaskToList(task: Solvable) {
    wrongTasksArray.append("\(task.a) \(operationsSign) \(task.b) = \(task.result)")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? GameOverViewController {
      destination.displayedScore = score.getScore()
      destination.wrongAnswersArray = wrongTasksArray
    }
  }
}
