//
//  PresentationController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class PresentationController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        self.presentedView()!.frame = self.containerView!.bounds
        self.containerView?.addSubview(self.presentedView()!)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        
    }
    
    override func dismissalTransitionWillBegin() {
        
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        self.presentedView()!.removeFromSuperview()
    }
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
}
