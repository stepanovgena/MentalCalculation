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
    
    

    @IBOutlet weak var aLabel: UILabel!
     @IBOutlet weak var bLabel: UILabel!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var digitButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
     @IBOutlet weak var livesLabel: UILabel!
    
   
    
   
    
   // lazy var task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
    
    var difficulty: String = "Easy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
    
    
        
    }
    
    func play() {
        
        while lives > 0 {
            
            task = game.generateTask(category: game.gameCategory, level: game.gameLevel)
            
           
        
    
//        ((self.parent as! UINavigationController).viewControllers[1] as! SelectCategoryViewController).selectedLevel
       
            //Timer start
//        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (t) in //Timer(timeInterval:3 , repeats: true, block: { (t) in
//
////                self.resultLabel.text = "\(count)"
//
//                    t.invalidate()
//
//
//            }) //end of closure
        
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
    
    func updateScore() {
        score.setScore(newValue: score.getScore() + 10 * (task.level.rawValue * (self.gameCategory.rawValue))) //the score is calculated as task difficulty * level difficulty * 10
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
//
            showResultWithColor(isCorrect: true)
            updateScore()
            clearResponseLabel()
            updateTask()
            updateViewFromModel()
            
        
            
        } else {
//
            showResultWithColor(isCorrect: false)
            lives -= 1
            if lives == 0 {
                performSegue(withIdentifier: "gameOverSegue", sender: self)
            } else {
            
            clearResponseLabel()
            updateTask()
            updateViewFromModel()
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
    
//    @objc func hideKeyboard() {
//        self.endEditing(true)
//    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    

}
