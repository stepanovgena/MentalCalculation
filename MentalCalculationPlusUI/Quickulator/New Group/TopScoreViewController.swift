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
  @IBOutlet weak var backButton: CornerRadiusButton!
  @IBOutlet weak var resetButton: UIButton!
  
  private let score = Score()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyColorScheme()
    showScore()
  }
  
  func showScore() {
    topScoreLabel.text = "\u{1F3C6}Top score: \(score.getTopScore())"
  }
  
  func applyColorScheme() {
    view.backgroundColor = ColorScheme.backgroundColor
    resetButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
    topScoreLabel.textColor = ColorScheme.primaryFontColor
    backButton.backgroundColor = ColorScheme.actionButtonFillColor
    backButton.setTitleColor(ColorScheme.actionButtonTextColor, for: .normal)
  }
  
  @IBAction func didTapResetTopScore(_ sender: UIButton) {
    
    let alertController = UIAlertController(title: "Reset Top Score", message:
      "Do you really want to reset your top score to 0?", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Reset", style: .destructive) {(action:UIAlertAction) in
      self.score.resetTopScore()
      self.showScore()
    })
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    self.present(alertController, animated: true, completion: nil)
  }
}
