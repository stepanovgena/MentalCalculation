//
//  PauseGameViewController.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 07/02/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class PauseGameViewController: UIViewController {

  
  
  @IBOutlet weak var resumeButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
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
  
  @IBAction func resumeButtonPressed(_ sender: Any) {
    let navigationController = self.presentingViewController as? UINavigationController 
    let destination = navigationController?.viewControllers[1] as? GameViewController
    destination?.updateProgressBar()
    
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func backToMenuButtonPressed(_ sender: Any) {
    let navigationController = self.presentingViewController as? UINavigationController
    navigationController?.popToRootViewController(animated: false)
    
     self.dismiss(animated: false, completion: nil)
  }
  
}
