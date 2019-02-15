//
//  File.swift
//  VKClient
//
//  Created by Gennady Stepanov on 31/01/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

final class CustomDismissModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = 0.3
  var presenting = true
  var originFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    
    let fromView = transitionContext.view(forKey: .from)!
    let toView = transitionContext.view(forKey: .to)!
    
    fromView.clipsToBounds = false
    toView.clipsToBounds = false
    containerView.addSubview(toView)
    containerView.addSubview(fromView)
    fromView.alpha = 1
    
    UIView.animate(withDuration: duration,
                   animations: { fromView.alpha = 0 },
                   completion: { _ in
                    transitionContext.completeTransition(true)
    })
   }
  }
  
  
  
  
  

