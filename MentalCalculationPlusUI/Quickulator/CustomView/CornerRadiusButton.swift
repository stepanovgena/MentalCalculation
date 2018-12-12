//
//  CornerRadiusButton.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 12/12/2018.
//  Copyright © 2018 Gennady Stepanov. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable class CornerRadiusButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat = 5 {
    didSet {
      refreshCorners(value: cornerRadius)
    }
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
    refreshCorners(value: cornerRadius)
  }
  
  func refreshCorners(value: CGFloat) {
    layer.cornerRadius = value
  }
}
