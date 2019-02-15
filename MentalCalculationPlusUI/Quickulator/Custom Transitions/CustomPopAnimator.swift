//
//  CustomPopAnimator.swift
//  VKClient
//
//  Created by Gennady Stepanov on 30/01/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.8
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let source = transitionContext.viewController(forKey: .from) else { return }
    guard let destination = transitionContext.viewController(forKey: .to) else { return }
    
    let width = source.view.frame.width
    let initialTranslation = CGAffineTransform(translationX: -100, y: 0)
    let initialScale = CGAffineTransform(scaleX: 0.8, y: 0.8)
    
    transitionContext.containerView.addSubview(destination.view)
    transitionContext.containerView.sendSubviewToBack(destination.view)
    destination.view.frame = source.view.frame
    destination.view.transform = initialScale.concatenating(initialTranslation)
   
    UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                            delay: 0,
                            options: .calculationModePaced,
                            animations: {
                          UIView.addKeyframe(withRelativeStartTime: 0,
                                    relativeDuration: 0.8,
                                    animations: {
                                    let translation = CGAffineTransform(translationX: 0, y: 0)
                                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                                    destination.view.transform = scale.concatenating(translation)
                              })
                            
                          UIView.addKeyframe(withRelativeStartTime: 0,
                                    relativeDuration: 0.8,
                                    animations: {
                                    let translation = CGAffineTransform(translationX: width, y: 0)
                                    source.view.transform = translation
                              })
    }) { finished in
      if finished && !transitionContext.transitionWasCancelled {
         destination.view.transform = .identity
      } else if (transitionContext.transitionWasCancelled) {
        destination.view.transform = .identity
        source.view.transform = .identity
      }
      transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
    }
  }
}
