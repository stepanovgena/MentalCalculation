//
//  CrossView.swift
//  Quickulator
//
//  Created by Gennady Stepanov on 13/02/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class CrossView: UIView {
  
  let crossColor = UIColor.red
  
  override func draw(_ rect: CGRect) {
    
    let crossPath = UIBezierPath()
    crossPath.move(to: CGPoint.zero)
    crossPath.addLine(to: CGPoint(x: super.bounds.width, y: super.bounds.height))
    crossPath.move(to: CGPoint(x: 0, y: super.bounds.height))
    crossPath.addLine(to: CGPoint(x: super.bounds.width, y: 0))
    crossPath.close()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = crossPath.cgPath
    shapeLayer.strokeEnd = 0
    shapeLayer.lineWidth = 3
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor
    
    self.layer.addSublayer(shapeLayer)
    
    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeEndAnimation.toValue = 1
    strokeEndAnimation.duration = 2
    strokeEndAnimation.isRemovedOnCompletion = false
    strokeEndAnimation.fillMode = .forwards

    shapeLayer.add(strokeEndAnimation, forKey: nil)
  }
}
