//
//  PaintHandleImageView.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

typealias PaintHandleImageViewBlock=(image:UIImage)->Void

class PaintHandleImageView: UIView,UIGestureRecognizerDelegate {
    var callBack=PaintHandleImageViewBlock?()
    private var _image:UIImage?
    var image:UIImage?{
        get{
            return self._image
        }
        set{
            self._image=newValue
            imageView.image=newValue
        }
    }
    var imageView:UIImageView!
    
    override func drawRect(rect: CGRect) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame=frame
        // 添加UIImageView
        addImageView()
        // 添加手势
        addLongpressGestureRecognizer()
        addRotationGestureRecognizer()
        addPinchGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addImageView(){
        self.imageView=UIImageView(frame: self.bounds)
        self.imageView.userInteractionEnabled=true // 允许用户交互
        self.addSubview(self.imageView)
    }
    
    /// 添加长按手势
    func addLongpressGestureRecognizer() {
        // 1.长按
        let longpress:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: "longpress:")
        self.imageView.addGestureRecognizer(longpress)
    }
    
    func longpress(longpress:UILongPressGestureRecognizer){
        if(longpress.state == UIGestureRecognizerState.Ended){
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imageView.alpha=0.3
                }, completion: { (finished) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.imageView.alpha=1
                        }, completion: { (finished) -> Void in
                            // 1.截屏
                            let newImage=UIImage.imageWithCaptureView(self)
                            // 2.把图片传给控制器
                            if(self.callBack != nil){
                                self.callBack!(image: newImage)
                            }
                            // 3.把自己移除父控件
                            self.removeFromSuperview()
                    })
            })
        }
    }
    
    // 添加旋转手势
    func addRotationGestureRecognizer(){
        let rotation=UIRotationGestureRecognizer(target: self, action: "rotation:")
        self.imageView.addGestureRecognizer(rotation)
    }
    
    func rotation(rotation:UIRotationGestureRecognizer){
        self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, rotation.rotation)
        // 复位
        rotation.rotation=0
    }
    
    // 添加缩放手势
    func addPinchGestureRecognizer(){
        let pinch=UIPinchGestureRecognizer(target: self, action: "pinch:")
        self.imageView.addGestureRecognizer(pinch)
    }
    
    func pinch(pinch:UIPinchGestureRecognizer){
        self.imageView.transform=CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale)
        // 复位
        pinch.scale=1
    }
    
    // 开启多手势支持
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
