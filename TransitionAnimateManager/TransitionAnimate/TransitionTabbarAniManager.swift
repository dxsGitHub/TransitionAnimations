//
//  TransitionTabbarAniManager.swift
//  TransitionAnimateManager
//
//  Created by High on 2021/5/19.
//

import UIKit

class TransitionTabbarAniManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    ///动画时长
    private var duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
    

}
