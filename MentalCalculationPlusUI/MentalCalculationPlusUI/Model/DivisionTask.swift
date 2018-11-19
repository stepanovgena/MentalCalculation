//
//  DivisionTask.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 28/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

class DivisionTask: Solvable {
    let level: Level
    let a: Int
    let b: Int
    let result: Int
    
    required init(level: Level) {
        
        self.level = level
        
        switch level {
        case .easy:
            b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 6)
            a =  RandomNumberFactory.generateInLimits(lower: 2, upper: 10) * b
            
        case .normal:
            b =  RandomNumberFactory.generateInLimits(lower: 2, upper: 10)
            a =  RandomNumberFactory.generateInLimits(lower: 2, upper: 20) * b

            
        case .hard:
            let distribution = Distribution.generate(from: 1, to: 10, separateBy: 8)// set probability distribution
            
            switch distribution {
            
            case .optionOne:
            b =  RandomNumberFactory.generateInLimits(lower: 5, upper: 9)
            a =  RandomNumberFactory.generateInLimits(lower: 20, upper: 99) * b
            
            case .optionTwo:
            b =  RandomNumberFactory.generateInLimits(lower: 11, upper: 19)
            a =  b * b
                
            }
        }
        result = a / b
    }
}
