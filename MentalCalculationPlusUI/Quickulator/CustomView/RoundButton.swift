//
//  RoundButton.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 12/12/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable class RoundButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat {
    return frame.height/2
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  override func prepareForInterfaceBuilder() {
    sharedInit()
  }
  
  func sharedInit() {
    setCornerRadius(value: cornerRadius)
  }
  
  func setCornerRadius(value: CGFloat) {
    layer.cornerRadius = value    
  }
  
  func refreshCornerRadius() {
    layer.cornerRadius = cornerRadius
  }
  
}
