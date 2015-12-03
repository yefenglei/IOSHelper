//
//  SessionNetworkViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/3.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class SessionNetworkViewController: UIViewController,NSURLSessionDownloadDelegate {

    var process:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        self.addProgressor()
        self.addNormalDownloadButton()
        self.addDownloadButton()
        self.addContinuedDownloadButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 添加进度条
    func addProgressor(){
        process=UIProgressView()
        process.frame=CGRectMake(20, 80, 200, 20)
        self.view.addSubview(process)
    }
    
    /// 添加普通下载按钮
    func addNormalDownloadButton(){
        let button=UIButton(type: UIButtonType.Custom)
        button.frame=CGRectMake(20, 100, 160, 30)
        button.addTarget(self, action: "downloadTask", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.setTitle("普通下载", forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    /// 添加带进度的下载按钮
    func addDownloadButton(){
        let button=UIButton(type: UIButtonType.Custom)
        button.frame=CGRectMake(20, 150, 160, 30)
        button.addTarget(self, action: "sessionDownload", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.setTitle("带进度条的下载", forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    /// 添加可断点的下载按钮
    func addContinuedDownloadButton(){
        let button=UIButton(type: UIButtonType.Custom)
        button.frame=CGRectMake(20, 200, 160, 30)
        button.addTarget(self, action: "sessionContinuedDownload:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.setTitle("断点下载", forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    /// get 请求
    func sessionGet(){
        // 1.得到session对象
        let session:NSURLSession=NSURLSession.sharedSession()
        // 2.创建一个task
        let urlStr:String="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        let url:NSURL=NSURL(string: urlStr)!
        let task:NSURLSessionDataTask=session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                NSLog("%@", error!)
                MBProgressHUD.showError("网络在开小差，请稍后再试!")
            }else{
                var dictData:NSDictionary?
                do{
                    dictData=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                }catch{
                
                }
                if(dictData == nil){
                    MBProgressHUD.showError("Json数据转换失败!")
                }else{
                    let name:String = dictData!.valueForKey("name") as! String
                    let nickname:String = dictData!.valueForKey("nick") as! String
                    let message:String="姓名:\(name),绰号:\(nickname)"
                    
                    
                    // 回主线程
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        MBProgressHUD.showSuccess(message)
                    })
                    
                }
                NSLog("下载完成")
            }
        })
        task.resume()
    }
    
    /// post 请求
    func sessionPostDemo(){
        // 1.得到session对象
        let session:NSURLSession=NSURLSession.sharedSession()
        // 2.创建一个task
        let url:NSURL = NSURL(string: "http://localhost/ThinkPHP/index.php/Home/Index/getJson")!
        let request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
        // 设置超时时间
        request.timeoutInterval=10 //10秒
        request.HTTPMethod="POST"
        // 设置请求体
        let param:String="username=yefenglei&password=123456"
        request.HTTPBody=param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        // 设置请求头信息
        request.setValue("IPhone5.9", forHTTPHeaderField: "User-Agent")
        
        let task:NSURLSessionDataTask=session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                NSLog("%@", error!)
                MBProgressHUD.showError("网络在开小差，请稍后再试!")
            }else{
                var dictData:NSDictionary?
                do{
                    dictData=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                }catch{
                    
                }
                if(dictData == nil){
                    MBProgressHUD.showError("Json数据转换失败!")
                }else{
                    let name:String = dictData!.valueForKey("name") as! String
                    let nickname:String = dictData!.valueForKey("nick") as! String
                    let message:String="姓名:\(name),绰号:\(nickname)"
                    
                    // 回主线程
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        MBProgressHUD.showSuccess(message)
                    })
                    
                    
                }
                NSLog("下载完成")
            }
        })
        // 3.开始任务
        task.resume()
    }
    
    // MARK: - 普通的下载文件
    func downloadTask(){
        let session:NSURLSession=NSURLSession.sharedSession()
        let urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        let url:NSURL = NSURL(string: urlStr)!
        let task:NSURLSessionDownloadTask=session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
            NSLog("下载完毕--%@",location!)
            let cachePath:NSString=NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last!
            let filepath:String=cachePath.stringByAppendingPathComponent(response!.suggestedFilename!)
            let sourcePath:String=location!.path!
            // 将临时文件剪切到caches文件夹
            let mgr:NSFileManager=NSFileManager.defaultManager()
            do{
                try mgr.moveItemAtPath(sourcePath, toPath: filepath)
            }catch{
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                MBProgressHUD.hideHUD()
            })
        })
        task.resume()
        MBProgressHUD.showMessage("正在下载...")
    }
    
    // MARK: - 带进度的下载
    func sessionDownload(){
        let sessionConfig=NSURLSessionConfiguration.defaultSessionConfiguration()
        let session:NSURLSession = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        let url:NSURL = NSURL(string: urlStr)!
        let task:NSURLSessionDownloadTask=session.downloadTaskWithURL(url)
        task.resume()
    }
    
    /* Sent when a download task that has completed a download.  The delegate should
    * copy or move the file at the given location to a new location as it will be
    * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
    * still be called.
    */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        NSLog("下载完成")
        let cachePath:NSString=NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last!
        let filepath:String=cachePath.stringByAppendingPathComponent(downloadTask.response!.suggestedFilename!)
        let sourcePath:String=location.path!
        // 将临时文件剪切到caches文件夹
        let mgr:NSFileManager=NSFileManager.defaultManager()
        do{
            try mgr.moveItemAtPath(sourcePath, toPath: filepath)
        }catch{
            
        }
        MBProgressHUD.showMessage("下载完成", duration: 1000)
    }
    
    /* Sent periodically to notify the delegate of download progress. */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        let currentProcess=Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
        self.process.progress=Float(currentProcess)
        //NSLog("当前进度:\(currentProcess*100.0)%" )
    }

    /* Sent when a download has been resumed. If a download failed with an
    * error, the -userInfo dictionary of the error will contain an
    * NSURLSessionDownloadTaskResumeData key, whose value is the resume
    * data.
    */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
        
    }
    
    // MARK: - 断点下载
    var urlsession:NSURLSession!
    var dlTask:NSURLSessionDownloadTask!
    var resumeData:NSData?
    
    func sessionInit(){
        let sessionConf=NSURLSessionConfiguration.defaultSessionConfiguration()
        urlsession=NSURLSession(configuration: sessionConf, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
    }
    var oneToken:dispatch_once_t=dispatch_once_t()
    
    func sessionContinuedDownload(sender: UIButton) {
        // 只执行一次
        dispatch_once(&oneToken, { () -> Void in
            self.sessionInit()
        })
        sender.selected = !sender.selected
        if(sender.selected){
            sender.setTitle("暂停", forState: UIControlState.Selected)
            if(self.resumeData==nil){
                self.start()
            }else{
                self.resume()
            }
        }else{
            sender.setTitle("继续", forState: UIControlState.Normal)
            self.pause()
        }
        
    }
    
    func start(){
        let urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        let url:NSURL = NSURL(string: urlStr)!
        dlTask = urlsession.downloadTaskWithURL(url)
        dlTask.resume()
        
    }
    
    func resume(){
        self.dlTask=self.urlsession.downloadTaskWithResumeData(self.resumeData!)
        self.dlTask.resume()
        self.resumeData=nil
    }
    
    func pause(){
        self.dlTask.cancelByProducingResumeData { (data) -> Void in
            self.resumeData=data
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
