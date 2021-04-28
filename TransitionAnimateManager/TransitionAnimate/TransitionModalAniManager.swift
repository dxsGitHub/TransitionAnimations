//
//  TransitionModalAniManager.swift
//  MaskTransitionDemo
//
//  Created by High on 2021/4/28.
//  Copyright © 2021 High. All rights reserved.
//

import UIKit

enum TransitionModelType {
    case present
    case dismiss
}

class TransitionModalAniManager: NSObject, UIViewControllerAnimatedTransitioning {

    ///动画时长
    private var duration: TimeInterval = 0.5
    
    ///动画风格
    private var modalType: TransitionModelType = .present
    
    
    init(duration: TimeInterval = 0.5, modalType: TransitionModelType) {
        super.init()
        self.modalType = modalType
        self.duration = duration
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if modalType == .present {
            presentAnimateTransition(using: transitionContext)
            
        } else {
           dismissAnimateTransition(using: transitionContext)
        }
    }
    
    
    ///模态展示动画
    func presentAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVc = transitionContext.viewController(forKey: .to), let toView = toVc.view else {
            return
        }
        
        let containerView = transitionContext.containerView
        let size = UIScreen.main.bounds.size
        containerView.addSubview(toView)
        toView.transform = CGAffineTransform.init(translationX: size.width, y: 0)
        toView.alpha = 0.0
        
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            toView.alpha = 1.0
            toView.transform = .identity
        } completion: { (isFinish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
    ///模态消失动画
    func dismissAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVc = transitionContext.viewController(forKey: .from), let frowView = fromVc.view else {
            return
        }
        
        let size = UIScreen.main.bounds.size
        frowView.transform = .identity
        
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            frowView.alpha = 0.0
            frowView.transform = CGAffineTransform.init(translationX: size.width, y: 0)
            
        } completion: { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
