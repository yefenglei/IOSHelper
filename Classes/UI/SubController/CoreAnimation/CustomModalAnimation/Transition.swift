//
//  Transition.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

class Transition: NSObject,UIViewControllerTransitioningDelegate {

    private static var _shareTransition:Transition?
    static var shareTransition:Transition{
        if(self._shareTransition==nil){
            self._shareTransition=Transition()
        }
        return self._shareTransition!
    }
    
    @available(iOS 8.0, *)
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anim = AnimatedTransitioning()
        anim.presented=true
        return anim

    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anim = AnimatedTransitioning()
        anim.presented=false
        return anim
    }
    
}
