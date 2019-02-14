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
  @IBOutlet weak var mainTitle: UILabel!
  @IBOutlet weak var chooseOperationTitle: UILabel!
  @IBOutlet weak var limitedTimeTitle: UILabel!
  @IBOutlet weak var chooseLevelTitle: UILabel!
  @IBOutlet weak var topScoreButton: UIButton!
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
//  override var preferredStatusBarStyle : UIStatusBarStyle {
//    return .lightContent
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyColorScheme()
   // scrollView.contentSize = UIScreen.main.bounds.size
   
    
    let font = UIFont.systemFont(ofSize: 28)
    gameCategorySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                            for: .normal)

  }
  
  func applyColorScheme() {
    view.backgroundColor = ColorScheme.backgroundColor
    gameCategorySegmentedControl.tintColor = ColorScheme.secondaryFillColor
    gameLevelSegmentedControl.tintColor = ColorScheme.secondaryFillColor
    playButton.backgroundColor = ColorScheme.secondaryFillColor
    playButton.setTitleColor(ColorScheme.secondaryFontColor, for: .normal)
    mainTitle.textColor = ColorScheme.primaryFontColor
    chooseOperationTitle.textColor = ColorScheme.primaryFontColor
    limitedTimeTitle.textColor = ColorScheme.primaryFontColor
    chooseLevelTitle.textColor = ColorScheme.primaryFontColor
    topScoreButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
    
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


