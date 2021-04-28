//
//  TransitionAnimateDelegate.swift
//  MaskTransitionDemo
//
//  Created by High on 2021/4/28.
//  Copyright © 2021 High. All rights reserved.
//

import UIKit

class TransitionAnimateDelegate: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    ///传进来的frame
    var rect: CGRect = .zero
    
    ///需要做动画的View
    var transitionView: UIView?
    
    ///
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionModalAniManager.init(duration: 0.5, modalType: .present)
    }
    

    ///
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionModalAniManager.init(duration: 0.5, modalType: .dismiss)
    }
    
    
    ///
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {        
        let transition = TransitionPushAniManager.init(duration: 0.5, pushType: (operation == .push) ? .push : .pop)
        transition.rect = rect
        return transition
    }
    
}
