//
//  AlertViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/23.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

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
        btn.setTitle("弹出对话框", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: Selector("showAlertView:"), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func showAlertView(btn:UIButton){
        if #available(iOS 8.0, *) {
            let alertVc=UIAlertController(title: "警告", message: "你有严重的精神病，快吃药！", preferredStyle: UIAlertControllerStyle.Alert)
            alertVc.addTextFieldWithConfigurationHandler({ (tf:UITextField) -> Void in
                tf.placeholder="请输入用户名"
            })
            alertVc.addTextFieldWithConfigurationHandler({ (tf:UITextField) -> Void in
                tf.placeholder="请输入密码"
                tf.secureTextEntry=true
            })
            weak var weakalert=alertVc
            let action1=UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive, handler: { (action:UIAlertAction) -> Void in
                NSLog("你点击了确定--%@:%@",weakalert!.textFields!.first!.text!,weakalert!.textFields!.last!.text!)
            })
            let action2=UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: { (action:UIAlertAction) -> Void in
                NSLog("你点击了取消")
            })
            alertVc.addAction(action1)
            alertVc.addAction(action2)
            self.presentViewController(alertVc, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView = UIAlertView()
            alertView.title = "系统登录"
            alertView.message = "请输入用户名和密码！"
            alertView.addButtonWithTitle("取消")
            alertView.addButtonWithTitle("确定")
            alertView.cancelButtonIndex=0
            alertView.delegate=self;
            alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
            alertView.show()
        }
        
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if(buttonIndex==alertView.cancelButtonIndex){
            print("点击了取消")
        }
        else
        {
            let name = alertView.textFieldAtIndex(0)
            let password = alertView.textFieldAtIndex(1)
            print("用户名是：\(name!.text) 密码是：\(password!.text)")
        }
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
