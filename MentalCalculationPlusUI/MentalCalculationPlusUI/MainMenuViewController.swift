//
//  ViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 06/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
//       self.preferredStatusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }

}

