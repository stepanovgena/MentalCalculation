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
    
    var displayedScore: Int = 0
    
    var wrongAnswersArray = [String]()

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var wrongTasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        wrongTasksTableView.dataSource = self
        
        wrongTasksTableView.tableFooterView = UIView()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backToMainMenuButtonPressed(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        

        scoreLabel.text = "\u{1F3C6}Your score: \(displayedScore)"
        
    }
    //return to Select Category
    @IBAction func backToMainMenuButtonPressed(_ sender: UIButton) {
        let controllerStack = self.navigationController?.viewControllers
        _ = self.navigationController?.popToViewController((controllerStack?[1])!, animated: true)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
