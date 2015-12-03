//
//  NativeNetworkViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/2.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class NativeNetworkViewController: UIViewController,NSURLConnectionDataDelegate {

    
    // MARK: - 下载大文件
    var data:NSMutableData=NSMutableData()
    var totalLength:Int64!
    var writeHandle:NSFileHandle!
    var currentLength:Int64=0
    @IBAction func btnDownloadBigData(sender: UIButton) {
        let urlStr:String="http://dlsw.baidu.com/sw-search-sp/soft/cc/13478/npp_6.8.7_Installer.1448862261.exe"
        let url:NSURL = NSURL(string: urlStr)!
        let request:NSURLRequest=NSURLRequest(URL: url)
        let conn:NSURLConnection=NSURLConnection(request: request, delegate: self)!
    }
    
    // 1.接受到服务器的响应就会调用
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        // 获取文件总大小
        //var response:NSHTTPURLResponse=response as! NSHTTPURLResponse
        //totalLength=response.allHeaderFields["Content-Length"]?.longLongValue
        
        if(self.currentLength>0){
            return
        }
        
        totalLength=response.expectedContentLength
        
        // 创建一个跟服务器端文件一样大的文件 到沙盒 中
        let mgr:NSFileManager=NSFileManager.defaultManager()
        let cache:NSString = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last!
        //let cache:NSString = NSHomeDirectory()
        // 文件路径
        let filePath:String=cache.stringByAppendingPathComponent("notepad++.exe")
        // 创建空文件到沙盒
        mgr.createFileAtPath(filePath, contents: nil, attributes: nil)
        //创建一个用来写数据的文件句柄
        self.writeHandle=NSFileHandle(forWritingAtPath: filePath)!
    }
    
    // 2.当接收到服务器返回的实体数据时调用
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        //        self.data.appendData(data)
        currentLength=currentLength+data.length
        self.progress.progress = Float(currentLength)/Float(totalLength)
        //        NSLog("\(self.data.length)")
        // 移动到文件的最后面
        self.writeHandle.seekToEndOfFile()
        // 写入数据
        self.writeHandle.writeData(data)
    }
    
    // 3.加载完毕后调用
    func connectionDidFinishLoading(connection: NSURLConnection) {
        NSLog("下载完毕")
        //        var cache:String = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last as! String
        //        var filePath:String=cache.stringByAppendingString("bilibili.jpg")
        //        // 写到沙盒中
        //        self.data.writeToFile(filePath, atomically: true)
        
        self.writeHandle.closeFile()
        self.writeHandle=nil
        self.totalLength=0
        self.currentLength=0
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("下载出错了")
    }
    
    @IBOutlet weak var progress: UIProgressView!
    
    // MARK: - 发起post请求
    
    @IBAction func postRequestClicked(sender: UIButton) {
        self.postRequest()
    }
    func postRequest(){
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
        
        // 发送一个同步请求
        let queue:NSOperationQueue=NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
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
                    
                    MBProgressHUD.showSuccess(message)
                }
            }
        }
    }
    
    // 断点下载
    var conn:NSURLConnection!
    @IBAction func continuedDownloadClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if(sender.selected){
            sender.setTitle("暂停", forState: UIControlState.Selected)
            let url:NSURL = NSURL(string: "http://down.pcgeshi.com/FormatFactory_setup.exe")!
            let request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
            // 设置请求头
            let range:String="bytes=\(self.currentLength)-"
            request.setValue(range, forHTTPHeaderField: "Range")
            // 下载 发起一个异步请求
            self.conn=NSURLConnection(request: request, delegate: self)
        }else{
            sender.setTitle("继续", forState: UIControlState.Normal)
            // 暂停下载
            self.conn.cancel()
            self.conn=nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
