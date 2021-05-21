//
//  TransitionAnimateDelegate.swift
//  MaskTransitionDemo
//
//  Created by High on 2021/4/28.
//  Copyright © 2021 High. All rights reserved.
//

import UIKit

class TransitionAnimateDelegate: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    ///传进来的frame
    var rect: CGRect = .zero
    
    ///需要做动画的View
    var transitionView: UIView?
    
    
    ///模态转场Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionModalAniManager.init(duration: 0.5, modalType: .present)
    }
    

    ///模态转场Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionModalAniManager.init(duration: 0.5, modalType: .dismiss)
    }
    
    
    ///导航Push 和 Pop
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {        
        let transition = TransitionPushAniManager.init(duration: 0.5, pushType: (operation == .push) ? .push : .pop)
        transition.rect = rect
        return transition
    }
    
    
    ///UITabBarController转场
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionTabbarAniManager.init()
    }
}
