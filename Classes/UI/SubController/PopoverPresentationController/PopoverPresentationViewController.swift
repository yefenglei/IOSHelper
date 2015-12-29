//
//  PopoverPresentationViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/23.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class PopoverPresentationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.whiteColor()
        
        self.addButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addButton(){
        let btn=UIButton()
        btn.size=CGSizeMake(100, 24)
        btn.center=self.view.center
        btn.setTitle("Pop", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: Selector("popview:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func popview(btn:UIButton){
        let secondView=SecondPopViewController()
        if #available(iOS 8.0, *) {
            secondView.modalPresentationStyle=UIModalPresentationStyle.Popover
            secondView.popoverPresentationController?.sourceView=btn
            secondView.popoverPresentationController?.sourceRect=btn.bounds
        }
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
