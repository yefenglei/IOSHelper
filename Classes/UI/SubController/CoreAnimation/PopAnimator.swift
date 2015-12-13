//
//  PopAnimator.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/13.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    let duration    = 1.0
    var presenting  = true
    var originFrame = CGRect.zero
    
    /// 动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    /// 转场动画核心代码
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 1.获取容器
        let containerView = transitionContext.containerView()!
        
        // 2.获取动画的起始view 和 目的view
        var toView:UIView!
        var fromView:UIView!
        if #available(iOS 8.0, *) {
            toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            fromView=transitionContext.viewForKey(UITransitionContextFromViewKey)!
        } else {
            toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view
            fromView=transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view
        }
        // 3.确定哪个view需要执行动画
        let herbView = presenting ? toView:fromView
        // 4.计算初始frame 和 最终frame 以及缩放比例
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        // 5.如果是执行跳转动画,需要初始化动画view的大小和位置，使其刚好盖在小的iamgeView上
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        // 6.将目的view和动画view都添加到过场动画容器里面
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        // 7.设置具体的动画
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            herbView.transform=self.presenting ? CGAffineTransformIdentity:scaleTransform
            herbView.center=CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame))
            }) { (completed) -> Void in
                transitionContext.completeTransition(true)
        }
        
        // 8.处理图片4个圆角
        let round=CABasicAnimation()
        round.keyPath="cornerRadius";
        round.fromValue = presenting ? 20.0 / xScaleFactor : 0.0
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        herbView.layer.addAnimation(round, forKey: nil)
        herbView.layer.cornerRadius=presenting ? 0.0 : 20.0/xScaleFactor
    }
}
