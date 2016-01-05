//
//  UnLockView.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/1.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class UnLockView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var btns:[UIButton]=[UIButton]()
    var moveP:CGPoint=CGPointMake(0, 0)
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let path:UIBezierPath=UIBezierPath()
        if(btns.count == 0){
            return
        }
        for i in 0...self.btns.count-1{
            let btn:UIButton=btns[i]
            if(0 == i){
                path.moveToPoint(btn.center)
            }else{
                path.addLineToPoint(btn.center)
            }
        }
        path.addLineToPoint(self.moveP)
        UIColor.greenColor().set()
        path.lineWidth=8
        path.lineJoinStyle=CGLineJoin.Round
        // 渲染到视图
        path.stroke()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // 添加按钮
        addButtons()
    }
    
    func addButtons() {
        for i in 0...8 {
            let btn:UIButton=UIButton()
            // 设置普通状态下按钮的图片
            btn.setImage(UIImage(named: "m_2_100"), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: "m_3_100"), forState: UIControlState.Selected)
            // 禁止按钮交互
            btn.userInteractionEnabled = false
            btn.tag = i
            self.addSubview(btn)
        }
    }
    // 获取触摸点
    func pointWithTouches(touches: Set<UITouch>)->CGPoint{
        let touch:UITouch=touches.first!
        return touch.locationInView(self)
    }
    
    // 获取触摸按钮
    func buttonWithPoint(point:CGPoint)->UIButton?{
        let wh:CGFloat=30
        
        for btn in self.subviews{
            let x:CGFloat = btn.center.x-wh*CGFloat(0.5)
            let y:CGFloat = btn.center.y-wh*CGFloat(0.5)
            let frame:CGRect=CGRectMake(x, y, wh, wh)
            if(CGRectContainsPoint(frame, point)){ //点在按钮上
                return (btn as! UIButton)
            }
        }
        return nil
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 当前触摸点
        
        let pos:CGPoint=self.pointWithTouches(touches)
        // 获取触摸按钮
        let btn:UIButton?=self.buttonWithPoint(pos)
        if(btn != nil && btn?.selected == false){ //有触摸按钮的时候才需要选中
            btn?.selected=true
            btns.append(btn!)
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 当前触摸点
        
        let pos:CGPoint=self.pointWithTouches(touches)
        self.moveP=pos
        // 获取触摸按钮
        let btn:UIButton?=self.buttonWithPoint(pos)
        if(btn != nil && btn?.selected == false){ //有触摸按钮的时候才需要选中
            btn?.selected=true
            btns.append(btn!)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var str:String=""
        for btn:UIButton in btns{
            str = str+"\(btn.tag)"
        }
        NSLog(str)
        
        // 1.清空所有按钮的选中状态
        self.btns.map(UnSelected)
        self.btns.removeAll(keepCapacity: true)
        // 2.重绘
        setNeedsDisplay()
    }
    
    func UnSelected(btn:UIButton)->UIButton{
        btn.selected=false
        return btn
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var col:Int=0
        var row:Int=0
        let btnW:CGFloat=74
        let btnH:CGFloat=74
        var btnX:CGFloat=0
        var btnY:CGFloat=0
        let tolCol:Int=3
        let margin:CGFloat = (self.bounds.size.width - CGFloat(tolCol)*btnW)/CGFloat(tolCol + 1)
        // 给按钮设置位置
        for i in 0...self.subviews.count-1{
            let btn:UIButton = self.subviews[i] as! UIButton;
            col = i % 3
            row = i / 3
            btnX = margin+(margin+btnW)*CGFloat(col)
            btnY=(margin+btnH)*CGFloat(row)
            btn.frame=CGRectMake(btnX, btnY, btnW, btnH)
        }
    }

}
