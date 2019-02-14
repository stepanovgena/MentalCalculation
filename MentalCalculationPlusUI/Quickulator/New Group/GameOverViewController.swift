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
  @IBOutlet weak var playAgainButton: CornerRadiusButton!
  
  var displayedScore: Int = 0
  var wrongAnswersArray = [[String]]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    wrongTasksTableView.register(UINib(nibName: "WrongAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "wrongAnswerCellReuseIdentifier")
    
//    wrongTasksTableView.estimatedRowHeight = 44.0
//    wrongTasksTableView.rowHeight = UITableView.automaticDimension
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(popToViewController))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)
    
    scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
  }
  
  @IBAction func pauseButtonPressed(_ sender: UIButton) {
    popToViewController(index: 0)
  }
  //return to Select Category
  @objc func popToViewController(index: Int) {

    if let controllerStack = navigationController?.viewControllers {
      let numberOfControllersInStack = controllerStack.count
      if (index < numberOfControllersInStack) {
        if (index == 1) {
          let gameViewController = controllerStack[1] as! GameViewController
          gameViewController.refreshState()
          navigationController?.popToViewController((controllerStack[index]), animated: true)
        } else {
        _ = self.navigationController?.popToViewController((controllerStack[index]), animated: true)
       }
      }
    }
  }
  
  @IBAction func didTapPlayAgain(_ sender: Any) {
    popToViewController(index: 1)
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wrongAnswersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "wrongAnswerCellReuseIdentifier") as! WrongAnswerTableViewCell
    
    let mistake = wrongAnswersArray[indexPath.row]
    cell.aLabel.text = mistake[0]
    cell.sign.text = mistake[1]
    cell.bLabel.text = mistake[2]
    cell.mistake.text = mistake[3]
    cell.correctValue.text = mistake[4]
      
    print("cell hooked up at \(indexPath)")
    print(cell.bounds)
    return cell
  }
}
