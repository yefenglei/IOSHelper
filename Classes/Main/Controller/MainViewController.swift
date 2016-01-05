//
//  MainViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/19.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func UIButtonClicked(sender: UIButton) {
        // 跳转到UI tableview
        var vc:BaseTableViewController?
        switch(sender.titleLabel!.text!.lowercaseString){
            case "ui":
                vc=UserInterfaceViewController()
                break
            case "network":
                vc=NetworkViewController()
                break
            case "function":
                vc=FunctionViewController()
                break
            case "threads":
                vc=ThreadsViewController()
                break
            case "device":break
            case "more":break
            default:break
        }
        if(vc==nil){
            return
        }
        self.navigationController?.showViewController(vc!, sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(UIScreen.mainScreen().bounds)
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
