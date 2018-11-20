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
    
    var responseString: String = String()
    var operationsSign: String = ""
    
     lazy var game: Game = Game(gameCategory: self.gameCategory, gameLevel: self.gameLevel)
    
    lazy var task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
    
    var score: Score = Score()
    
    var lives: Int = 3
    
    var timer: Timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(t) in })
    
    

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
    
    
   
    
   // lazy var task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
    
    var difficulty: String = "Easy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
        updateProgressBar()
    
    
        
    }
    
    func play() {
        
        while lives > 0 {
            
            task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
            
        
        
        }
        
        
        
//        let gr:UIGestureRecognizer = self.view.gestureRecognizers![0]
//        gr.addTarget(self, action: #selector(swipeRight))
        

    }
    
    func updateViewFromModel() {
        aLabel.text = String(task.a)
        bLabel.text = String(task.b)
        operationLabel.text = operationsSign
        
        scoreLabel.text = "\u{1F3C6}\(score.currentScore)"
        
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
    
    @objc func swipeRight(_ sender: UIGestureRecognizer) {
        performSegue(withIdentifier: "segueToGame", sender: self)
        
    }
    
    func showResultWithColor (isCorrect: Bool) {
        if isCorrect {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.green
            }, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = UIColor.black
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.red
            }, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = UIColor.black
            }, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        Get the new view controller using segue.destination.
        //        Pass the selected object to the new view controller.
        if let destination = segue.destination as? GameOverViewController {
            destination.displayedScore = score.getScore()
        }
    }
    
    
    func updateProgressBar() {
        
        progressBar.setProgress(0, animated: false)
        progressBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        var progress: Float  = 0.0
        
       
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(t) in
            
            progress += 0.001
            self.progressBar.setProgress(progress, animated: true)
            
            if (progress > 0.999) {
                t.invalidate()
               // print("Is timer valid: \(t.isValid)")
                self.enterButtonPressed(self.enterButton)
            }
            
            
        })
       
       
    }
    
    
    
//    @objc func hideKeyboard() {
//        self.endEditing(true)
//    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    

}
