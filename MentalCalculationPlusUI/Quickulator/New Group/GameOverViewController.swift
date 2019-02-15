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
  @IBOutlet weak var mainTitle: UILabel!
  @IBOutlet weak var mistakesLabel: UILabel!
  
  var displayedScore: Int = 0
  var wrongAnswersArray = [[String]]()

  //MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    applyColorScheme()
    wrongTasksTableView.register(UINib(nibName: "WrongAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "wrongAnswerCellReuseIdentifier")
    
    scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
  }
  
  func applyColorScheme() {
    view.backgroundColor = ColorScheme.backgroundColor
    mainTitle.textColor = ColorScheme.primaryFontColor
    scoreLabel.textColor = ColorScheme.primaryFontColor
    mistakesLabel.textColor = ColorScheme.primaryFontColor
    wrongTasksTableView.backgroundColor = ColorScheme.backgroundColor
    playAgainButton.backgroundColor = ColorScheme.actionButtonFillColor
    playAgainButton.setTitleColor(ColorScheme.secondaryFontColor, for: .normal)
    backToMainMenuButton.backgroundColor = ColorScheme.secondaryButtonFillColor
    backToMainMenuButton.setTitleColor(ColorScheme.secondaryButtonFontColor, for: .normal)
  }
  
  //MARK: tableView delegate methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wrongAnswersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "wrongAnswerCellReuseIdentifier") as! WrongAnswerTableViewCell
    
    let mistake = wrongAnswersArray[indexPath.row]
    //mapping task items to labels
    cell.aLabel.text = mistake[0]
    cell.sign.text = mistake[1]
    cell.bLabel.text = mistake[2]
    cell.mistake.text = mistake[3]
    cell.correctValue.text = mistake[4]
    
    return cell
  }
  
  //MARK: Navigation
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
  
  @IBAction func didTapBackToMenu(_ sender: UIButton) {
    popToViewController(index: 0)
  }

  @IBAction func didTapPlayAgain(_ sender: Any) {
    popToViewController(index: 1)
  }
}
