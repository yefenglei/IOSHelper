//
//  FirstModalViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

class FirstModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        let label=UILabel()
        label.text="Touch to go to SecondView"
        label.textColor=UIColor.blueColor()
        label.frame.size=CGSizeMake(250, 24)
        label.center=self.view.center
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let secondView = SecondModalViewController()
        secondView.view.frame=self.view.frame
        secondView.view.backgroundColor=UIColor.redColor()
        secondView.transitioningDelegate=Transition.shareTransition
        secondView.modalPresentationStyle=UIModalPresentationStyle.Custom
        self.presentViewController(secondView, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
