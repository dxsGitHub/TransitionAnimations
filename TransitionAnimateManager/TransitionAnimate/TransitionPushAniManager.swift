//
//  TransitionAnimateManager.swift
//  MaskTransitionDemo
//
//  Created by High on 2021/4/28.
//  Copyright © 2021 High. All rights reserved.
//

import UIKit

enum TransitionPushType {
    case push
    case pop
}

class TransitionPushAniManager: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    ///动画时长
    private var duration: TimeInterval = 0.5
    
    ///动画风格
    private var pushType: TransitionPushType = .push
    
    ///原来的Rect
    var rect: CGRect = .zero
    
    
    init(duration: TimeInterval = 0.5, pushType: TransitionPushType) {
        super.init()
        self.pushType = pushType
        self.duration = duration
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if pushType == .push {
            pushAnimateTransition(using: transitionContext)
            
        } else {
            popAnimateTransition(using: transitionContext)
        }
    }
    
    
    ///Push动画
    func pushAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVc = transitionContext.viewController(forKey: .from), let fromView = fromVc.view, let toVc = transitionContext.viewController(forKey: .to), let toView = toVc.view else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let startPoint = CGPoint.init(x: 0, y: 0)
        let radius: CGFloat = 30.0
        
        //创建UIBezierPath路径 作为后面动画的起始路径
        let startPath = UIBezierPath.init(arcCenter: startPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: true)

        let x = startPoint.x
        let y = startPoint.y

        let radius_x = (x > containerView.frame.size.width - x) ? x : (containerView.frame.size.width - x)
        let radius_y = (y > containerView.frame.size.height - y) ? y : (containerView.frame.size.height - y)

        let endRadius = sqrt(pow(radius_x, 2) + pow(radius_y, 2))

        let endPath = UIBezierPath.init(arcCenter: startPoint, radius: endRadius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)

        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = endPath.cgPath
        toView.layer.mask = shapeLayer

        let animation = CABasicAnimation.init(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.duration = duration
        shapeLayer.add(animation, forKey: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            shapeLayer.removeAllAnimations()
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
    ///Pop动画
    func popAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVc = transitionContext.viewController(forKey: .from), let fromView = fromVc.view, let toVc = transitionContext.viewController(forKey: .to), let toView = toVc.view else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, at: 0)

        
        let startPoint = CGPoint.init(x: 0, y: 0)
        let radius: CGFloat = 30.0

        //创建UIBezierPath路径 作为后面动画的起始路径

        let x = startPoint.x
        let y = startPoint.y

        let radius_x = (x > containerView.frame.size.width - x) ? x : (containerView.frame.size.width - x)
        let radius_y = (7 > containerView.frame.size.height - y) ? y : (containerView.frame.size.height - y)

        let startRadius = sqrt(pow(radius_x, 2) + pow(radius_y, 2))

        let startPath = UIBezierPath.init(arcCenter: startPoint, radius: startRadius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)

        let endPath = UIBezierPath.init(arcCenter: startPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: true)


        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = endPath.cgPath
        fromView.layer.mask = shapeLayer

        let animation = CABasicAnimation.init(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.duration = duration
        shapeLayer.add(animation, forKey: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            shapeLayer.removeAllAnimations()
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    ///layer动画回调
    func animationEnded(_ transitionCompleted: Bool) {
        print("动画结束")
    }
}
