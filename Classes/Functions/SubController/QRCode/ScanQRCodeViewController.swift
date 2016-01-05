//
//  ScanQRCodeViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/24.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var session:AVCaptureSession!
    var previewLayer:AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()


        // 1.实例化拍摄设备
        let device:AVCaptureDevice=AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // 2.设置输入设备
        do{
            let input:AVCaptureDeviceInput=try AVCaptureDeviceInput(device: device)
            // 3. 设置元数据输出
            // 3.1 实例化拍摄元数据输出
            let output:AVCaptureMetadataOutput=AVCaptureMetadataOutput()
            // 3.2 设置输出数据代理
            output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            // 4.添加拍摄会话
            // 4.1 实例化拍摄会话
            let session:AVCaptureSession=AVCaptureSession()
            // 4.2 添加会话输入
            session.addInput(input)
            // 4.3 添加会话输出
            session.addOutput(output)
            // 4.4 设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
            output.metadataObjectTypes=[AVMetadataObjectTypeQRCode]
            
            self.session=session
            
            // 5.视频预览图层
            // 5.1 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
            let preview:AVCaptureVideoPreviewLayer=AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = AVLayerVideoGravityResizeAspectFill
            preview.frame = self.view.bounds
            // 5.2 将图层插入当前视图
            self.view.layer.insertSublayer(preview, atIndex: 100)
            
            self.previewLayer=preview
            
            // 6.启动会话
            self.session.startRunning()
            
        }catch{
            NSLog("设置输入设备失败")
        }
        
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // 会频繁的扫描，调用代理方法
        // 1.如果扫描完成，停止会话
        self.session.stopRunning()
        // 2.删除预览图层
        self.previewLayer.removeFromSuperlayer()
        
        NSLog("%@", metadataObjects)
        // 3. 设置界面显示扫描结果
        if(metadataObjects.count>0){
            let obj:AVMetadataMachineReadableCodeObject=metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
            //        _label.text = obj.stringValue;
            NSLog("%@", obj.stringValue);
        }

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
