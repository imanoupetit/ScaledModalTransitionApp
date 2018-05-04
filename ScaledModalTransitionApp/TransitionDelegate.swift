//
//  TransitionDelegate.swift
//  ImageTransitionApp
//
//  Created by Imanou on 04/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Getting the Transition Animator Objects
    
    // Only needed if a subclass of UIViewControllerAnimatedTransitioning is implemented; otherwise, return nil (default)
    // We want this here in order to have a custom animation or an interactive animation (with gesture)
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator()
    }
    
    // The system calls this method on the presented view controller's transitioningDelegate to retrieve the animator object used for animating the dismissal of the presented view controller.
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionAnimator = TransitionAnimator()
        transitionAnimator.isPresentation = false
        return transitionAnimator
    }
    
}
