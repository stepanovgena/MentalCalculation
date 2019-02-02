//
//  GameOverViewController.swift
//  MentalCalculationPlusUI
//
//  Created by Gennady Stepanov on 14/11/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var backToMainMenuButton: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var wrongTasksTableView: UITableView!
  
  var displayedScore: Int = 0
  var wrongAnswersArray = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(popToMainMenu))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)
    
    scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    popToMainMenu()
  }
  //return to Select Category
  @objc func popToMainMenu() {
    let index:Int = 0
    if let controllerStack = self.navigationController?.viewControllers {
      let numberOfControllersInStack = controllerStack.count
      if (index < numberOfControllersInStack) {
        _ = self.navigationController?.popToViewController((controllerStack[index]), animated: true)
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wrongAnswersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
    let text = wrongAnswersArray[indexPath.row]
    
    cell.textLabel?.text = text
    cell.contentView.backgroundColor = .black
    cell.textLabel?.textColor = .white
    cell.textLabel?.adjustsFontSizeToFitWidth = true
    cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
    cell.textLabel?.textAlignment = .center
    return cell
  }
  
}
