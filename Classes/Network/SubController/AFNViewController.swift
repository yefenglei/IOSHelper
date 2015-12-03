//
//  AFNViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/3.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class AFNViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        let label=UILabel()
        label.frame=CGRectMake(20, 80, 200, 30)
        label.font=UIFont.systemFontOfSize(15)
        label.text="具体使用请查阅源码"
        label.textColor=UIColor.blueColor()
        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get(){
        // 1.创建一个请求操作管理者
        let mgr:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        
        // 2.发送一个get请求
        let url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="123"
        
        mgr.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json","text/json","text/javascript","text/html"])as Set<NSObject>
        
        mgr.GET(url, parameters: params, success: { (operation, obj) -> Void in
            NSLog("请求成功")
            }) { (operation, error) -> Void in
                NSLog("请求失败")
                NSLog(error.userInfo.description)
        }
    }
    
    func post(){
        // 1.创建一个请求操作管理者
        let mgr:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        
        // 2.发送一个get请求
        let url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="123"
        
        mgr.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json","text/json","text/javascript","text/html"])as Set<NSObject>
        
        mgr.POST(url, parameters: params, success: { (operation, obj) -> Void in
            NSLog("请求成功")
            }) { (operation, error) -> Void in
                NSLog("请求失败")
                NSLog(error.userInfo.description)
        }

    }
    
    /// 上传文件
    func uploadFile(){
        let mgr:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="上传者"
        
        let url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        
        mgr.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        mgr.POST(url, parameters: params, constructingBodyWithBlock: { (fromDataObj) -> Void in
            let fromData:AFMultipartFormData = fromDataObj as AFMultipartFormData
            let image=UIImage(named: "Stars.png")
            let fileData=UIImagePNGRepresentation(image!)
            fromData.appendPartWithFileData(fileData!, name: "file", fileName: "hehe.png", mimeType: "image/png")
            
            
            }, success: { (operation, obj) -> Void in
                NSLog("上传成功")
            }) { (operation, error) -> Void in
                NSLog("上传失败")
                NSLog(error.userInfo.description)
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
