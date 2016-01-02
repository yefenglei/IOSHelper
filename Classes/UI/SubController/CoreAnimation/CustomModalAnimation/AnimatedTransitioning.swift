//
//  AnimatedTransitioning.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import Foundation
class AnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    let duration    = 1.0
    var presented:Bool=true
    /// 动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    /// 转场动画核心代码
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var toView:UIView?
        var fromView:UIView?
        if #available(iOS 8.0, *) {
            toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            fromView=transitionContext.viewForKey(UITransitionContextFromViewKey)
        } else {
            toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view
            fromView=transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view
        }
        if(self.presented){
            if let tv = toView{
                tv.x=tv.width
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    tv.x=0
                    }, completion: { (finished:Bool) -> Void in
                        transitionContext.completeTransition(true)
                })
            }
        }else{
            UIView.animateWithDuration(duration, animations: { () -> Void in
                fromView!.x = -fromView!.width
                }, completion: { (finished:Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
