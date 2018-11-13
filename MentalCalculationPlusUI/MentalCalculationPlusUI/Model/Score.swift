//
//  Score.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 19/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

class Score {
    var currentScore = 0
    private static var topScore = 0
    
    func getScore() -> Int {
    return currentScore
    }
    
    func setScore(newValue: Int) {
        currentScore = newValue
    }
    
    func updateTopScore() {
        if (currentScore > Score.topScore) {
            Score.topScore = currentScore
        }
    }
    static func getTopScore() -> Int {
        return topScore
    }
    
}
