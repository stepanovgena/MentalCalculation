//
//  PauseGameViewController.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 07/02/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class PauseGameViewController: UIViewController {
  
  var didClose: (() -> Void)?
  
  override func viewDidLoad() {
        super.viewDidLoad()
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
    navigationController?.popToRootViewController(animated: true)
    
  }
}
