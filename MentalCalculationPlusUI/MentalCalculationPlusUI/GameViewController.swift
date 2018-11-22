//
//  GameViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 07/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameCategory: GameCategory = .addition
    var gameLevel: Level = .easy
    
    private var responseString: String = String()
    var operationsSign: String = ""
    
    lazy var game: Game = Game(gameCategory: self.gameCategory, gameLevel: self.gameLevel)
    
    lazy var task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
    
    private var score: Score = Score()
    
    private var lives: Int = 3
    
    //don't like this instance member with exact parameters
    private var timer: Timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(t) in })
    
    

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
        updateProgressBar()
        
    }
    
    
    func updateViewFromModel() {
        aLabel.text = String(task.a)
        bLabel.text = String(task.b)
        operationLabel.text = operationsSign
        
        scoreLabel.text = "\u{1F3C6}\(score.getScore())"
        
        livesLabel.text = "\u{2764}\(lives)"
    }
    
    func updateTask() {
        task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
    }
    
    //the score is calculated as task difficulty * level difficulty * 10
    func updateScore() {
        score.setScore(newValue: score.getScore() + 10 * (task.level.rawValue * (self.gameCategory.rawValue)))
    }
    
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
        
        if (String(task.result) == responseString) {
            timer.invalidate()
            showResultWithColor(isCorrect: true)
            updateScore()
            clearResponseLabel()
            updateTask()
            updateViewFromModel()
            updateProgressBar()
            
        
            
        } else {
            timer.invalidate()
            showResultWithColor(isCorrect: false)
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
    
    func showResultWithColor (isCorrect: Bool) {
        if isCorrect {
            //blink green if the answer is correct
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.green
            }, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = UIColor.black
            }, completion: nil)

        } else {
            //blink red if the answer is incorrect
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.red
            }, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = UIColor.black
            }, completion: nil)
            
        }
    }
    
    
    
    func updateProgressBar() {
        
        progressBar.setProgress(0, animated: false)
        progressBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        var progress: Float  = 0.0
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(t) in
            
            progress += 0.001
            self.progressBar.setProgress(progress, animated: true)
            
            //if timer runs out then stop timer and programmatically press Enter
            if (progress > 0.999) {
                t.invalidate()
                self.enterButtonPressed(self.enterButton)
            }
            
            
        })
       
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameOverViewController {
            destination.displayedScore = score.getScore()
        }
    }
    

}
