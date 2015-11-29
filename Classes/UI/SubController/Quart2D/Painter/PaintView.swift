//
//  PaintView.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class PaintView: UIView {
    
    var lineWidth:CGFloat=2
    var color:UIColor=UIColor.blackColor()
    var path:PaintPath!
    lazy var paths:[PaintPath]=[PaintPath]()
    
    private var _image:UIImage?
    var image:UIImage?{
        get{
            return self._image
        }
        set{
            self._image=newValue
            self.setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        // 刷新屏幕的时候 重绘图片
        // let link:CADisplayLink=CADisplayLink(target: self, selector: "setNeedsDisplay")
        // link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    /**/
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if(self.image != nil){
            self.image!.drawAtPoint(CGPointZero)
        }
        
        for path in self.paths{
            path.color.set()
            path.stroke()
        }
    }
    
    /// 获取触摸点的位置
    func pointWithTouches(touches:Set<NSObject>)->CGPoint{
        let touch:UITouch=touches.first! as! UITouch
        return touch.locationInView(self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 获取触摸点
        let pos:CGPoint=self.pointWithTouches(touches)
        path=PaintPath(lineWidth: self.lineWidth, lineColor: self.color, startPoint: pos)
        paths.append(path)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 获取触摸点
        let pos:CGPoint=self.pointWithTouches(touches)
        // 确定终点
        path.addLineToPoint(pos)
        // 重新绘制
        self.setNeedsDisplay()
    }
    
    /// 清屏
    func clearScreen(){
        self.paths.removeAll()
        self.image=nil
        self.setNeedsDisplay()
    }
    
    /// 撤销
    func undo(){
        if(self.paths.count>0){
            self.paths.removeLast()
        }
        self.setNeedsDisplay()
    }
    
    /// 橡皮擦
    func eraser(){
        color=UIColor.whiteColor()
    }
    
    /// 保存到相册
    func save(){
        
    }

}
