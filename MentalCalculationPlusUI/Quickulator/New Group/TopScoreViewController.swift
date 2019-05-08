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
    localizeStrings()
    showScore()
  }
  
  func showScore() {
    topScoreLabel.text = "\u{1F3C6}\(NSLocalizedString("Top Score", comment: "TopScore label")): \(score.getTopScore())"
  }
  
  func applyColorScheme() {
    view.backgroundColor = ColorScheme.backgroundColor
    resetButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
    topScoreLabel.textColor = ColorScheme.primaryFontColor
    backButton.backgroundColor = ColorScheme.actionButtonFillColor
    backButton.setTitleColor(ColorScheme.actionButtonTextColor, for: .normal)
  }
  
  func localizeStrings() {
    resetButton.setTitle(NSLocalizedString("Reset Top Score", comment: "Press button to reset top score"), for: .normal)
    //topScoreLabel.text = NSLocalizedString("Top Score", comment: "Top score label")
    backButton.setTitle(NSLocalizedString("Back to Menu", comment: "press button to return to main menu"), for: .normal)
  }
  
  @IBAction func didTapResetTopScore(_ sender: UIButton) {
    
    let alertController = UIAlertController(title: NSLocalizedString("Reset Top Score", comment: "Alert title"), message:
      NSLocalizedString("Do you really want to reset your top score to 0?", comment: "Alert message"), preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: NSLocalizedString("Reset", comment: "Press button to reset topscore"), style: .destructive) {(action:UIAlertAction) in
      self.score.resetTopScore()
      self.showScore()
    })
    alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel resetting top score"), style: .cancel))
    
    present(alertController, animated: true, completion: nil)
  }
}
