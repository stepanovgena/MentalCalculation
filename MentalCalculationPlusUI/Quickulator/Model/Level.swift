//
//  Level.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 13/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation
/**Enum provides levels of difficulty, raw values are used in score calculation*/
enum Level: Int {
  case easy = 1
  case normal = 2
  case hard = 3
}

extension Level {
  static var array:[Int] {
    var a:[Int] = []
    switch Level.easy {
    case .easy: a.append(easy.rawValue); fallthrough
    case .normal: a.append(normal.rawValue); fallthrough
    case .hard: a.append(hard.rawValue)
    }
    return a
  }
}
