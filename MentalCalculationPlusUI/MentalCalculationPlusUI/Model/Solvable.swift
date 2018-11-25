//
//  Solvable.swift
//  MentalCalculation
//
//  Created by Gennady Stepanov on 30/10/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation
/**Protocol that all task types conform to*/
protocol Solvable {
    var level: Level { get }
    var a: Int { get }
    var b: Int { get }
    var result: Int { get }
    
    init (level: Level)
        
}
