//
//  QRCodeViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/24.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit
import CoreImage

class QRCodeViewController: UIViewController {
    
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
        setupQRCode()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupQRCode(){
        self.imageView=UIImageView()
        self.imageView.height=200
        self.imageView.width=200
        self.imageView.centerX=UIScreen.mainScreen().bounds.width/2
        self.imageView.centerY=UIScreen.mainScreen().bounds.height/2
        self.view.addSubview(self.imageView)
        
        // 1.实例化二维码滤镜
        let filter:CIFilter=CIFilter(name: "CIQRCodeGenerator")!
        
        // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
        filter.setDefaults()
        
        // 3.将字符串转换成NSdata
        let data:NSData=("http://www.bilibili.com" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
        filter.setValue(data, forKeyPath: "inputMessage")
        
        // 5.生成二维码
        let outputImage:CIImage?=filter.outputImage
        
        if(outputImage != nil){
            let image=UIImage(CIImage: outputImage!)
            // 6.设置生成好得二维码到imageview上
            self.imageView.image=image
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
