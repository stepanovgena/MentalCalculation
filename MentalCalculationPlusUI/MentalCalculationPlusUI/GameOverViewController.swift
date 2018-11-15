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
scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMainMenuButtonPressed(_ sender: UIButton) {
        let controllerStack = self.navigationController?.viewControllers
        _ = self.navigationController?.popToViewController((controllerStack?[0])!, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
