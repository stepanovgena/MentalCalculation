//
//  SelectCategoryViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 06/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var picker: UIPickerView!
  
  @IBOutlet weak var limitedTimeSwitch: UISwitch!
  
  var levels: [String] = []
  
  var selectedLevel: Level = .easy
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    levels = ["Easy", "Normal", "Hard"]
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let destination = segue.destination as? GameViewController {
      destination.gameLevel = selectedLevel
      
      switch segue.identifier {
        
      case "additionSegue":
        destination.gameCategory = .addition
        destination.operationsSign = "+"
        
      case "subtractionSegue":
        destination.gameCategory = .substraction
        destination.operationsSign = "-"
        
      case "multiplicationSegue":
        destination.gameCategory = .multiplication
        destination.operationsSign = "*"
        
      case "divisionSegue":
        destination.gameCategory = .division
        destination.operationsSign = "/"
        
      default:
        destination.gameCategory = .addition
        destination.operationsSign = "+"
      }
      
      if !limitedTimeSwitch.isOn {
        destination.limitedTimeToResolve = false
      }
      
    }
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Number of columns of data
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return levels.count
  }
  
  // The data to return fopr the row and component (column) that's being passed in
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return NSAttributedString(string: levels[row], attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    selectedLevel = Level(rawValue: row+1)!
  }
}
