//
//  ViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 06/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
  @IBOutlet weak var gameCategorySegmentedControl: UISegmentedControl!
  @IBOutlet weak var gameLevelSegmentedControl: UISegmentedControl!
  @IBOutlet weak var limitedTimeSwitch: UISwitch!
  @IBOutlet weak var playButton: UIButton!
  //@IBOutlet weak var scrollView: UIScrollView!
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
    super.viewWillAppear(animated)
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
   // scrollView.contentSize = UIScreen.main.bounds.size
   
    
    let font = UIFont.systemFont(ofSize: 28)
    gameCategorySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                            for: .normal)

  }
  
  @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
    
  }
  
  @IBAction func playButtonPressed(_ sender: UIButton) {
    //segue in storyboard
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let level: Level = Level(rawValue: gameLevelSegmentedControl.selectedSegmentIndex + 1) ?? .easy
    let category: GameCategory = GameCategory(rawValue: gameCategorySegmentedControl.selectedSegmentIndex + 1) ?? .addition
    if let destination = segue.destination as? GameViewController {
  
      destination.gameLevel = level
      destination.gameCategory = category
      if !limitedTimeSwitch.isOn {
        destination.limitedTimeToResolve = false
      }
    }
  }
}


