//
//  TopScoreViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 14/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class TopScoreViewController: UIViewController {
    @IBOutlet weak var topScoreLabel: UILabel!
    
    let score = Score()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topScoreLabel.text = "\u{1F3C6}Top score: \(score.getTopScore())"
        // Do any additional setup after loading the view.
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
