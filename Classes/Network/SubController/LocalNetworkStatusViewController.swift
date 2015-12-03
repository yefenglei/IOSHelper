//
//  LocalNetworkStatusViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/3.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class LocalNetworkStatusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        self.addButtons()
        
        listenNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtons(){
        let btnCheck3G=UIButton(frame: CGRectMake(20,80,160,30))
        btnCheck3G.setTitle("检查2G/3G信号", forState: UIControlState.Normal)
        btnCheck3G.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        let btnCheckWifi=UIButton(frame: CGRectMake(20,130,160,30))
        btnCheckWifi.setTitle("检查wifi信号", forState: UIControlState.Normal)
        btnCheckWifi.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnCheck3G.addTarget(self, action: "checkNetworkStatus:", forControlEvents: UIControlEvents.TouchUpInside)
        btnCheckWifi.addTarget(self, action: "checkNetworkStatus:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnCheck3G)
        self.view.addSubview(btnCheckWifi)
    }
    
    func checkNetworkStatus(button:UIButton){
        if(button.titleLabel!.text=="检查2G/3G信号"){
            if(NetworkTool.isEnable3G()){
                MBProgressHUD.showMessage("当前是2g或3g网路", duration: 1000)
            }else{
                MBProgressHUD.showMessage("当前不是2g或3g网路", duration: 1000)
            }
        }else if(button.titleLabel!.text=="检查wifi信号"){
            if(NetworkTool.isEnableWifi()){
                MBProgressHUD.showMessage("当前是wifi网路", duration: 1000)
            }else{
                MBProgressHUD.showMessage("当前不是wifi网路", duration: 1000)
            }
        }
    }
    
    var reachability:Reachability!
    /// 监听手机网络变化
    func listenNetwork(){
        // 监听网络状态发生改变的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "networkChanged", name: kReachabilityChangedNotification, object: nil)
        // 活的Reachability对象
        reachability=Reachability.reachabilityForInternetConnection()
        reachability.startNotifier()
    }
    
    func networkChanged(){
        checkLocalNetStatus()
    }
    
    func checkLocalNetStatus(){
        if(NetworkTool.isEnableWifi()){
            MBProgressHUD.showMessage("当前是wifi网路", duration: 1000)
        }else if(NetworkTool.isEnable3G()){
            MBProgressHUD.showMessage("当前是2g或3g网路", duration: 1000)
        }else{
            MBProgressHUD.showMessage("没有网络", duration: 1000)
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
