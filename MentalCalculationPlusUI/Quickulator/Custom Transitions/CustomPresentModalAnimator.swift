//
//  CustomPresentModalAnimator.swift
//  VKClient
//
//  Created by Gennady Stepanov on 31/01/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

final class CustomPresentModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
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
    
    //prepare blur effect on source viewController
    fromView.backgroundColor = UIColor.clear
    let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let blurView = UIVisualEffectView(effect: effect)
    blurView.frame = fromView.bounds
    blurView.clipsToBounds = false
    fromView.addSubview(blurView)
    
    //take snaphot from the source VC and set it as destination's background view
    let snapshot = fromView.snapshotView(afterScreenUpdates: true)!
    toView.addSubview(snapshot)
    toView.sendSubviewToBack(snapshot)
    blurView.removeFromSuperview()
    containerView.addSubview(toView)
    
    //prepare initial state for the sliding effect
    toView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
    toView.alpha = 0.0
    
    //animate sliding from bottom
    UIView.animate(withDuration: duration,
                   animations: {
                    toView.transform = CGAffineTransform(translationX: 0, y: 0)
                    toView.alpha = 1.0
    },
                   completion: { _ in
                    transitionContext.completeTransition(true)
    }
    )
  }
}
