//
//  Quartz2DViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/27.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class Quartz2DViewController: UIViewController {
    
    @IBAction func clipImage(sender: UIButton) {
        // 圆环宽度
        let borderW:CGFloat=5
        
        // 加载旧的图片
        if(self.paintView.image==nil){
            return
        }
        let oldImage:UIImage=self.paintView.image!
        
        // 新的图片尺寸
        let imageW:CGFloat=oldImage.size.width+borderW*2
        let imageH:CGFloat=oldImage.size.height+borderW*2
        
        // 设置新的图片尺寸
        let circleW:CGFloat=min(imageW, imageH)
        
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), false, 0)
        
        // 画大圆
        let path:UIBezierPath=UIBezierPath(ovalInRect: CGRectMake(0, 0, circleW, circleW))
        // 获取当前上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        
        CGContextAddPath(ctx, path.CGPath)
        UIColor.pinkLipstickColor().set()
        
        // 渲染
        CGContextFillPath(ctx)
        
        let newImageW:CGFloat=min(oldImage.size.width, oldImage.size.height)
        // 画圆 正切于旧图片
        let clipR:CGRect=CGRectMake(borderW, borderW, newImageW, newImageW)
        
        let clipPath:UIBezierPath=UIBezierPath(ovalInRect: clipR)
        
        // 设置裁剪区域
        clipPath.addClip()
        
        // 画图片
        oldImage.drawAtPoint(CGPointMake(borderW, borderW))
        
        // 获取新的图片
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        self.paintView.image=newImage
        
    }
    
    @IBAction func loadImage(sender: UIButton) {
        self.paintView.image=UIImage(named: "cloudphotos")
    }
    
    @IBAction func drawArc(sender: UIButton) {
        // 0.开启上下文
        UIGraphicsBeginImageContext(self.paintView.size)
        
        // 1.获取上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        
        CGContextSaveGState(ctx)
        
        let center:CGPoint=CGPointMake(150, 150)
        let radius:CGFloat=CGFloat(100)
        let startP:CGFloat=0
        let endP:CGFloat=CGFloat(M_PI)
        
        let path=UIBezierPath(arcCenter: center, radius: radius, startAngle: startP, endAngle: endP, clockwise: false)
        
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        
        let newImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 2.关闭上下文
        UIGraphicsEndImageContext()
        
        self.paintView.image=newImage
    }
    
    @IBAction func drawCircle(sender: UIButton) {
        // 0.开启上下文
        UIGraphicsBeginImageContext(self.paintView.size)
        
        // 1.获取上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        
        // 保存上下文状态
        CGContextSaveGState(ctx)
        
        // 2.拼接路径
        let path=UIBezierPath(ovalInRect: CGRectMake(10, 10, 200, 200))
        
        CGContextAddPath(ctx, path.CGPath)
        
        CGContextStrokePath(ctx)
        
        let image=UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭当前上下文
        UIGraphicsEndImageContext()
        
        self.paintView.image=image
        
    }
    
    @IBAction func drawTheRect(sender: UIButton) {
        // 0.开启上下文
        UIGraphicsBeginImageContext(self.paintView.size)
        
        // 1.获取上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        
        // 保存上下文状态
        CGContextSaveGState(ctx)
        
        // 2.拼接路径
        let path:UIBezierPath=UIBezierPath(rect: CGRectMake(10, 10, 200, 200))
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        
        // 获取上下文中的图片
        let newImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        self.paintView.image=newImage
    }
    @IBOutlet weak var paintView: UIImageView!
    
    @IBAction func drawTriangle(sender: UIButton) {
        
        // 0.开启上下文
        UIGraphicsBeginImageContext(self.paintView.size)
        
        // 1.获取上下文
        let ctx:CGContextRef=UIGraphicsGetCurrentContext()!
        
        // 保存上下文状态
        CGContextSaveGState(ctx)
        
        // 2.拼接路径
        let path:UIBezierPath=UIBezierPath()
        // 3.设置起点
        path.moveToPoint(CGPointMake(10, 10))
        path.addLineToPoint(CGPointMake(10, 110))
        path.addLineToPoint(CGPointMake(110, 110))
        path.closePath()
        // 4.添加到上下文
        CGContextAddPath(ctx, path.CGPath)
        
        UIColor.blueberryColor().setFill()
        UIColor.redColor().setStroke()
        CGContextSetLineWidth(ctx, 5)
        // 5.渲染到上下文
        CGContextDrawPath(ctx, CGPathDrawingMode.Fill)
        
        // 获取上下文中的图片
        let newImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        self.paintView.image=newImage
        
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
