//
//  SubstractionTask.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 24/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

class SubstractionTask: Solvable {
    let level: Level
    let a: Int
    let b: Int
    let result: Int
    
    required init(level: Level) {
        
        self.level = level
        
        switch level {
        case .easy:
            a =  RandomNumberFactory.generateInLimits(lower: 3, upper: 99)
            
            let bUpperLimit: Int
            if (a < 10) {
                bUpperLimit = a - 1
            } else {
                bUpperLimit = 9
            }
            
            b =  RandomNumberFactory.generateInLimits(lower: 2, upper: bUpperLimit)
            
        case .normal:
            a =  RandomNumberFactory.generateInLimits(lower: 10, upper: 999)
            
            let bUpperLimit: Int
            if (a < 100) {
                bUpperLimit = a - 1
            } else {
                bUpperLimit = 99
            }
            
            b =  RandomNumberFactory.generateInLimits(lower: 2, upper: bUpperLimit)
            
        case .hard:
            a =  RandomNumberFactory.generateInLimits(lower: 100, upper: 999)
            b =  RandomNumberFactory.generateInLimits(lower: 10, upper: a - 1)
            
        }
        
        if (a >= b) {
        result = a - b
        } else {
            result = b - a
        }
    }
}
