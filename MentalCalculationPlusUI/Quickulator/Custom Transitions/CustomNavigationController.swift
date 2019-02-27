//
//  CustomNavigationController.swift
//  VKClient
//
//  Created by Gennady Stepanov on 30/01/2019.
//  Copyright © 2019 Gennady Stepanov. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  let interactiveTransition = CustomInteractiveTransition()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  
  func navigationController(_ navigationController: UINavigationController,
                            interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      return interactiveTransition.hasStarted ? interactiveTransition : nil
  }

  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if (operation == .push) {
      interactiveTransition.viewController = toVC
      return CustomPushAnimator()
    }
    else if (operation == .pop) {
      if (navigationController.viewControllers.first != toVC) {
        interactiveTransition.viewController = toVC
      }
      return CustomPopAnimator()
    }
    return nil
  }
}

