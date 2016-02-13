//
//  OtherViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/9.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {
    
    var textF:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        self.textF=UITextView()
        self.textF.frame=CGRectMake(0, 0, self.view.width, self.view.height)
        self.textF.text="获取源码  https://github.com/yefenglei/IOSHelper"
        self.textF.editable=false
        
        self.view.addSubview(self.textF)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
