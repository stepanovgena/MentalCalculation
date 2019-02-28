//
//  PauseGameViewController.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 07/02/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class PauseGameViewController: UIViewController {
  @IBOutlet weak var resumeButton: CornerRadiusButton!
  @IBOutlet weak var backButton: CornerRadiusButton!
  
  var didClose: (() -> Void)?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        applyColorScheme()
        localizeStrings()
    }
    
  func applyColorScheme() {
    resumeButton.backgroundColor = ColorScheme.actionButtonFillColor
    resumeButton.setTitleColor(ColorScheme.actionButtonTextColor, for: .normal)
    backButton.backgroundColor = ColorScheme.secondaryButtonFillColor
    backButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
  }
  
  func localizeStrings() {
    resumeButton.setTitle(NSLocalizedString("Resume Game", comment: "Press button to resume game"), for: .normal)
    backButton.setTitle(NSLocalizedString("Back to Menu", comment: "Press button to return to menu"), for: .normal)
  }
  
  @IBAction func resumeButtonPressed(_ sender: Any) {
    let navigationController = self.presentingViewController as? UINavigationController 
    let destination = navigationController?.viewControllers[1] as? GameViewController
    destination?.isGamePaused = false
    didClose?()
  }
  
  @IBAction func backToMenuButtonPressed(_ sender: Any) {
    didClose?()
    let navigationController = self.presentingViewController as? UINavigationController
    navigationController?.popToRootViewController(animated: false)
  }
}
