//
//  TransitionAnimator.swift
//  ImageTransitionApp
//
//  Created by Imanou on 04/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//


import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // navigation controllers, view controllers & views
        let presentingTransitionContextKey = isPresentation ? UITransitionContextViewControllerKey.from : .to
        let presentedTransitionContextKey = isPresentation ? UITransitionContextViewControllerKey.to : .from
        let presentingNavController = transitionContext.viewController(forKey: presentingTransitionContextKey) as! UINavigationController
        let presentedNavController = transitionContext.viewController(forKey: presentedTransitionContextKey) as! UINavigationController
        let presentingController = presentingNavController.topViewController as! ViewController
        let presentedController = presentedNavController.topViewController as! CyanViewController
        let orangeView = presentingController.orangeView
        
        if isPresentation {
            let containerView = transitionContext.containerView
            containerView.addSubview(presentedNavController.view)
        }
        
        // orangeView scale factor
        let orangeViewSize = orangeView.bounds.size
        let presentedControllerViewSize = presentedController.view.bounds.size
        let scaleFactor: CGFloat
        if presentedControllerViewSize.width < presentedControllerViewSize.height {
            scaleFactor = presentedControllerViewSize.width / orangeViewSize.width
        } else {
            scaleFactor = presentedControllerViewSize.height / orangeViewSize.height
        }
        
        // Translation
        let orangeViewFrame = orangeView.frame
        let yTranslation = orangeViewFrame.midY - presentedController.view.center.y
        
        // Full image Transform
        let scale = CGAffineTransform(scaleX: 0.001, y: 0.001)
        let fullImagePresentingTransform = scale.concatenating(CGAffineTransform(translationX: 0, y: yTranslation))
        let fullImagePresentedTransform = CGAffineTransform.identity
        presentedNavController.view.transform = isPresentation ? fullImagePresentingTransform : fullImagePresentedTransform
        presentedController.view.alpha = isPresentation ? 0 : 1
        
        // orangeView Transform
        let orangeViewPresentingTransform = CGAffineTransform.identity
        let concat = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let orangeViewPresentedTransform = concat.concatenating(CGAffineTransform(translationX: 0, y: -yTranslation))
        orangeView.transform = isPresentation ? orangeViewPresentingTransform : orangeViewPresentedTransform
        orangeView.alpha = isPresentation ? 1 : 0
        
        // Set parameters for animateWithDuration
        let duration = transitionDuration(using: transitionContext)
        let delay: TimeInterval = 0
        let damping: CGFloat = 1
        let initialVelocity: CGFloat = 1
        let options: UIViewAnimationOptions = [.curveLinear]
        let animations: () -> Void = {
            // Full image
            presentedNavController.view.transform = self.isPresentation ? fullImagePresentedTransform : fullImagePresentingTransform
            presentedController.view.alpha = self.isPresentation ? 1 : 0
            if !self.isPresentation { presentedController.view.backgroundColor = UIColor.clear }
            // orangeView
            orangeView.transform = self.isPresentation ? orangeViewPresentedTransform : orangeViewPresentingTransform
            orangeView.alpha = self.isPresentation ? 0 : 1
        }
        let completion: (Bool) -> Void = { bool in
            if self.isPresentation {
                // Put orangeView back to its initial frame when animation is over
                orangeView.transform = .identity
                orangeView.alpha = 1
            }
            if !self.isPresentation { presentedNavController.view.removeFromSuperview() }
            transitionContext.completeTransition(bool)
        }
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: options, animations: animations, completion: completion)
    }
    
}
