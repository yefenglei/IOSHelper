//
//  PaintViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    @IBOutlet weak var paintView: PaintView!
    
    @IBAction func btnColorChanged(sender: UIButton) {
        if let bgColor=sender.backgroundColor{
            self.paintView.color=bgColor
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        paintView.lineWidth=CGFloat(sender.value)
    }
    
    @IBAction func btnSaveClicked(sender: UIBarButtonItem) {
        // 把画板截屏
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(self.paintView.bounds.size, false, 0)
        // 获取当前上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        // 把画板上的内容渲染到上下文
        paintView.layer.renderInContext(ctx)
        // 获取新的图片
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 保存到用户的相册
        UIImageWriteToSavedPhotosAlbum(newImage, self, "saveToAlbum:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func saveToAlbum(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject){
        if(error != nil){
            MBProgressHUD.showError("保存失败")
        }else{
            MBProgressHUD.showSuccess("保存成功")
        }
    }
    
    @IBAction func btnSelectPictureClicked(sender: UIBarButtonItem) {
        // 去用户的相册
        let picker:UIImagePickerController=UIImagePickerController()
        picker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate=self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    // 选中照片的时候
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image=info[UIImagePickerControllerOriginalImage] as! UIImage
        let handleView=PaintHandleImageView(frame: self.paintView.frame)
        handleView.image=image
        handleView.backgroundColor=UIColor.whiteColor()
        handleView.callBack={(image:UIImage)->Void in
            self.paintView.image=image
        }
        self.view.addSubview(handleView)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 取消选择照片
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnEraserClicked(sender: UIBarButtonItem) {
        self.paintView.eraser()
    }
    
    @IBAction func btnUndoClicked(sender: UIBarButtonItem) {
        self.paintView.undo()
    }
    
    @IBAction func btnClearScreenClicked(sender: UIBarButtonItem) {
        self.paintView.clearScreen()
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
