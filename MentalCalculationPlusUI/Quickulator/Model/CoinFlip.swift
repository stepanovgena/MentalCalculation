//
//  CoinFlip.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 28/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

/**Utility class to provide coin flip probability logic */

enum Coin: Int {
  case heads = 1
  case tails = 2
  
  static func flip() -> Coin {
    
    let flip = RandomNumberFactory.generateInLimits(lower: 1, upper: 2)
    
    let coin = Coin(rawValue: flip)
    return coin!
  }
}
