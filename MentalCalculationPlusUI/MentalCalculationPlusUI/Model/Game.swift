//
//  Game.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 18/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

class Game {
    let gameCategory: GameCategory
    let gameLevel: Level
    var gameScore = Score()
    
    init(gameCategory: GameCategory, gameLevel: Level) {
        self.gameCategory = gameCategory
        self.gameLevel = gameLevel
    }
    
//    func play() {
//        var triesRemaining = 3
//       
//        gameScore.setScore(newValue: 0)
//         //var timer = GameTimer(gameCategory: gameCategory, gameLevel: gameLevel)
//            while (triesRemaining > 0) {
//               
//              let task = Game.generateTask(category: gameCategory, level: gameLevel)
//               
//                print("Уровень: \(task.level), Операция: \(self.gameCategory) \(task.a) и \(task.b)")
//             //   timer.start()
//                
//                let response = (readLine()! as NSString).integerValue
//                
////                timer.stop()
////                timer.check()
//                
//                if (response == task.result) {//correct response
//                    gameScore.setScore(newValue: gameScore.getScore() + 10 * (task.level.rawValue * (self.gameCategory.rawValue))) //the score is calculated as task difficulty * level difficulty * 10
//                    print("Correct")
//                }
//                    else {//incorrect response
//                        triesRemaining -= 1
//                    if (triesRemaining == 0) {//Game over
//                        print ("Game over. Your score is \(gameScore.getScore())")
//                        gameScore.updateTopScore()
//                        print("Top score: \(Score.getTopScore())")
//                    }
//                    }
//                }
//        
//        }
        
     func generateTask(category: GameCategory, level: Level) -> Solvable {
        switch category {
        case .addition: return AdditionTask(level: level)
        case .substraction: return SubstractionTask(level: level)
        case .multiplication: return MultiplicationTask(level: level)
        case .division: return DivisionTask(level: level)
            
        }
    }
    
    

}
