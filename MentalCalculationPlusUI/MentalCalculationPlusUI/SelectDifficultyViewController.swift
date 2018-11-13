//
//  SelectDifficultyViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 10/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class SelectDifficultyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        ((self.parent as! UINavigationController).viewControllers[1] as! SelectCategoryViewController).selectedLevel
        
        
        
        
//        let gr:UIGestureRecognizer = self.view.gestureRecognizers![0]
//        gr.addTarget(self, action: #selector(swipeRight))
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
//    @objc func swipeRight(_ sender: UIGestureRecognizer) {
//        performSegue(withIdentifier: "segueToLevel", sender: self)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
