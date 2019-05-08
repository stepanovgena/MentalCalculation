//
//  AdditionTask.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 21/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

/**Class provides addition task logic*/
class AdditionTask: Solvable {
  let level: Level
  let a: Int
  let b: Int
  let result: Int
  
  required init(level: Level) {
    
    self.level = level
    
    switch level {
    case .easy:
      a =  RandomNumberFactory.generateInLimits(lower: 2, upper: 99)
      b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 9)
      
    case .normal:
      a =  RandomNumberFactory.generateInLimits(lower: 10, upper: 999)
      b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 99)
      
    case .hard:
      a =  RandomNumberFactory.generateInLimits(lower: 100, upper: 999)
      b =  RandomNumberFactory.generateInLimits(lower: 10, upper: 999)
    }
    result = a + b
  }
}
