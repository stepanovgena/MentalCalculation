//
//  WrongAnswerTableViewCell.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 13/02/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class WrongAnswerTableViewCell: UITableViewCell {
  
  @IBOutlet weak var aLabel: UILabel!
  @IBOutlet weak var sign: UILabel!
  @IBOutlet weak var bLabel: UILabel!
  @IBOutlet weak var equals: UILabel!
  @IBOutlet weak var mistake: UILabel!
  @IBOutlet weak var correctValue: UILabel!
  
  lazy var labels: [UILabel] = [
  aLabel,
  sign,
  bLabel,
  equals,
  mistake,
  correctValue,
  ]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    aLabel.text = "222"
    sign.text = "+"
    bLabel.text = "333"
    mistake.text = "4444"
    correctValue.text = "5555"
    
    contentView.backgroundColor = .black
   
    for label in labels {
      label.textColor = .white
      label.numberOfLines = 1
      label.adjustsFontSizeToFitWidth = true
      label.minimumScaleFactor = 0.1
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
