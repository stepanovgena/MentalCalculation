//
//  Game.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 18/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation
/**Class generates task according to chosen task type and difficulty level*/
class Game {
  let gameCategory: GameCategory
  let gameLevel: Level
  var gameScore = Score()
  
  init(gameCategory: GameCategory, gameLevel: Level) {
    self.gameCategory = gameCategory
    self.gameLevel = gameLevel
  }

  func generateTask(category: GameCategory, level: Level) -> Solvable {
    switch category {
    case .addition: return AdditionTask(level: level)
    case .substraction: return SubstractionTask(level: level)
    case .multiplication: return MultiplicationTask(level: level)
    case .division: return DivisionTask(level: level)
    }
  } 
}
