//
//  GCDViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/2.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var oneToken:dispatch_once_t=0
    @IBAction func btnOnceCodeClicked(sender: UIButton) {
        dispatch_once(&oneToken) { () -> Void in
            MBProgressHUD.showMessage("这段代码只运行一次", duration: 2000)
        }
    }
    
    @IBAction func btnSDWebImageClicked(sender: UIButton) {
        let optionArray:SDWebImageOptions=[SDWebImageOptions.RetryFailed,SDWebImageOptions.LowPriority]
        let imgUrl:NSURL=NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")!
        let imagePlaceholder:UIImage=UIImage(named: "clock_body.jpg")!
        self.imageView.sd_setImageWithURL(imgUrl, placeholderImage: imagePlaceholder, options: optionArray, progress: { (receivedSize:Int, expectedSize:Int) -> Void in
            NSLog("下载进度：%f", Float(receivedSize) * 1.0 / Float(expectedSize))
            }, completed: { (img:UIImage!, error:NSError!, cacheType:SDImageCacheType, imgUrl:NSURL!) -> Void in
                if(error != nil){
                    MBProgressHUD.showMessage("下载图片失败", duration: 1000)
                    return
                }
                NSLog("图片加载完毕：%@", img)
        })
    }
    
    @IBAction func btnDownloadImageClicked(sender: UIButton) {
        let queue:NSOperationQueue=NSOperationQueue()
        NSLog("---下载图片---当前线程：%@", NSThread.currentThread())
        queue.addOperationWithBlock { () -> Void in
            let url:NSURL=NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")!
            let data:NSData=NSData(contentsOfURL: url)!
            let image:UIImage=UIImage(data: data)!
            NSLog("---下载图片---当前线程：%@", NSThread.currentThread())
            // 回主线程
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView.image=image
                NSLog("---下载图片---当前线程：%@", NSThread.currentThread())
            })
        }
    }
    
    @IBAction func btnThreadsDependencyClicked(sender: UIButton) {
        // 创建异步队列
        let queue:NSOperationQueue=NSOperationQueue()
        // 设置最大并发
        queue.maxConcurrentOperationCount=2
        // 创建闭包操作
        let operation1=NSBlockOperation { () -> Void in
            NSLog("任务队列1----当前线程%@",NSThread.currentThread() )
        }
        let operation2=NSBlockOperation { () -> Void in
            NSLog("任务队列2----当前线程%@",NSThread.currentThread() )
        }
        // 给operation2添加额外操作
        operation2.addExecutionBlock { () -> Void in
            NSLog("任务队列2 额外任务----当前线程%@",NSThread.currentThread() )
        }
        // 给operation2添加完成后的回调事件
        operation2.completionBlock={()->Void in
            NSLog("任务队列2 任务结束----当前线程%@",NSThread.currentThread() )
        }
        let operation3=NSBlockOperation { () -> Void in
            NSLog("任务队列3----当前线程%@",NSThread.currentThread() )
        }
        let operation4=NSBlockOperation { () -> Void in
            NSLog("任务队列4----当前线程%@",NSThread.currentThread() )
        }
        
        // 添加各个线程之间的依赖关系
        operation1.addDependency(operation2)
        operation3.addDependency(operation4)
        
        // 将操作添加到队列中
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        queue.addOperation(operation4)
        
        MBProgressHUD.showMessage("打开XCode控制台查看详情", duration: 1500)
    }
    
    @IBAction func btnCombineImageClicked(sender: UIButton) {
        let queue:dispatch_queue_t=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) { () -> Void in
            let url1:NSURL = NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")!
            let url2:NSURL = NSURL(string: "http://www.logoing.net/wp-content/uploads/2012/08/baidulogo1.jpg")!
            let data1:NSData=NSData(contentsOfURL: url1)!
            let data2:NSData=NSData(contentsOfURL: url2)!
            let image1:UIImage=UIImage(data: data1)!
            let image2:UIImage=UIImage(data: data2)!
            
            // 合并图片
            UIGraphicsBeginImageContextWithOptions(image1.size, false, 0)
            
            image1.drawInRect(CGRectMake(0, 0, image1.size.width, image1.size.width))
            image2.drawInRect(CGRectMake(0, 0, image2.size.width, image2.size.width))
            
            let fullImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
            
            // 关闭上下文
            UIGraphicsEndImageContext()
            // 返回主线程
            dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                self.imageView.image=fullImage
            })
        }
    }
    
    @IBAction func btnThreadsClicked(sender: UIButton) {
        // 获取全局并发队列
        let queue:dispatch_queue_t=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        // 将任务添加到全局队列中去异步执行
        dispatch_async(queue) { () -> Void in
            NSLog("---执行任务1---当前线程：%@", NSThread.currentThread())
        }
        dispatch_async(queue) { () -> Void in
            NSLog("---执行任务2---当前线程：%@", NSThread.currentThread())
        }
        dispatch_async(queue) { () -> Void in
            NSLog("---执行任务3---当前线程：%@", NSThread.currentThread())
        }
        dispatch_async(queue) { () -> Void in
            NSLog("---执行任务4---当前线程：%@", NSThread.currentThread())
        }
        dispatch_async(queue) { () -> Void in
            NSLog("---执行任务5---当前线程：%@", NSThread.currentThread())
        }
        MBProgressHUD.showMessage("打开XCode控制台查看详情", duration: 1500)
        
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
