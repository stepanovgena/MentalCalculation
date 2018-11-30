//
//  MultiplicationTask.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 24/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation
/**Class provides multiplication task logic*/
class MultiplicationTask: Solvable {
  let level: Level
  let a: Int
  let b: Int
  let result: Int
  
  required init(level: Level) {
    
    self.level = level
    
    switch level {
    case .easy:
      a =  RandomNumberFactory.generateInLimits(lower: 2, upper: 5)
      b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 10 - a)
      
    case .normal:
      let distribution = Distribution.generate(from: 1, to: 10, separateBy: 7)// set probability distribution to get normal task and squares
      
      switch distribution {
      case .optionOne:
        //normal multiplication
        a =  RandomNumberFactory.generateInLimits(lower: 5, upper: 99)
        
        if (a > 10) {
          b =  RandomNumberFactory.generateInLimits(lower: 3, upper: 9)
        } else {
          b =  RandomNumberFactory.generateInLimits(lower: 11, upper: 99)
        }
        
      case .optionTwo:
        
        //squares
        a =  RandomNumberFactory.generateInLimits(lower: 4, upper: 20)
        b = a
      }
      
    case .hard:
      
      let coinFlip = Coin.flip()// equalize probability
      
      switch coinFlip {
      case .heads:
        a =  RandomNumberFactory.generateInLimits(lower: 5, upper: 999)
        
      case .tails:
        a =  RandomNumberFactory.generateInLimits(lower: 5, upper: 99)
      }
      if (a > 100) {
        b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 5)//significantly simplify b if a > 100
      } else if (a > 10){
        b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 15)//slightly simplify b if 10 < а < 100
      } else {
        b = RandomNumberFactory.generateInLimits(lower: 2, upper: 99)
      }
    }
    result = a * b
  }

}
