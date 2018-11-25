//
//  GameOverViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 14/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var backToMainMenuButton: UIButton!
    
    var displayedScore: Int = 0

    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backToMainMenuButtonPressed(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        

        scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
        
    }
    //return to Select Category 
    @IBAction func backToMainMenuButtonPressed(_ sender: UIButton) {
        let controllerStack = self.navigationController?.viewControllers
        _ = self.navigationController?.popToViewController((controllerStack?[1])!, animated: true)
    }
    
}
