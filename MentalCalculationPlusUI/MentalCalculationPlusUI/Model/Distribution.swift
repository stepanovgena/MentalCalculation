//
//  Distribution.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 17/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

enum Distribution: Int {
    case optionOne = 1
    case optionTwo = 2
    
    static func generate(from: Int, to: Int, separateBy: Int) -> Distribution {
        assert((from > 0 && to > 0 && separateBy > 0 && to > from && to > separateBy), "Wrong arguents")
        
        let distribution: Distribution
        
        let number = Int.random(in: from...to)
        
        if number <= separateBy {
            distribution = Distribution(rawValue: 1)!
        } else {
            distribution = Distribution(rawValue: 2)!
        }
    return distribution
        
        
    }
    
    
}
