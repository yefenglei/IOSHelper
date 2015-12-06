//
//  CoreAnimationViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/6.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {
    
    var imageView:UIImageView!
    var layer:CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bounds=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()

        self.addAnCircle()
        self.addAnImageView()
        self.addControlButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnCircle(){
        let view1=UIView()
        view1.backgroundColor=UIColor.yellowColor()
        view1.frame=CGRectMake(20, 80, 100, 100)
        self.view.addSubview(view1)
        view1.layer.shadowOpacity=1
        view1.layer.shadowColor=UIColor.blueColor().CGColor
        view1.layer.shadowRadius=10
        view1.layer.cornerRadius=50
        view1.layer.borderColor=UIColor.pinkColor().CGColor
        view1.layer.borderWidth=2
    }
    
    func addAnImageView(){
        imageView=UIImageView()
        imageView.frame=CGRectMake(20, 200, 100, 100)
        self.view.addSubview(imageView)
        imageView.image=UIImage(named: "Stars")
        imageView.layer.cornerRadius=10
        imageView.layer.masksToBounds=true
    }
    
    func addControlButtons(){
        self.setupButton("旋转", frame: CGRectMake(20, 320, 80, 30), action: "rotate:")
        self.setupButton("平移", frame: CGRectMake(100, 320, 80, 30), action: "transform:")
        self.setupButton("缩放", frame: CGRectMake(180, 320, 80, 30), action: "scale:")
        
        self.setupButton("创建图层", frame: CGRectMake(20, 360, 80, 30), action: "createLayer")
        self.setupButton("隐式动画", frame: CGRectMake(100, 360, 80, 30), action: "animaLayer")
        self.setupButton("基本动画", frame: CGRectMake(180, 360, 80, 30), action: "basicAnimation")
        self.setupButton("路径动画", frame: CGRectMake(20, 400, 80, 30), action: "keyframeAnimation")
        self.setupButton("动画组", frame: CGRectMake(100, 400, 80, 30), action: "animationGroup")
        
        self.setupButton("转场动画", frame: CGRectMake(180, 400, 80, 30), action: "changeScene")
    }
    
    
    func setupButton(title:String,frame:CGRect,action:String){
        let btn=UIButton()
        btn.frame=frame
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    /// 旋转
    func rotate(button:UIButton){
        let random:UInt32=arc4random_uniform(4)
        switch(random){
            case 0:
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.imageView.layer.transform=CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
                })
            break
        case 1:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.imageView.layer.transform=CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0)
            })
            break
        case 2:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.imageView.layer.transform=CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
            })
            break
        case 3:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.imageView.layer.transform=CATransform3DMakeRotation(CGFloat(M_PI), 1, 1, 0)
            })
            break
            default:break
        }
    }
    /// 平移
    func transform(button:UIButton){
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            self.imageView.layer.transform=CATransform3DMakeTranslation(100, 100, 0)
//        })
        //使用kvc方式赋值
        let rotation=NSValue(CATransform3D:
            CATransform3DMakeTranslation(100, 100, 0))
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.imageView.layer.setValue(rotation, forKeyPath: "transform")
        })

    }
    /// 缩放
    func scale(button:UIButton){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.imageView.layer.transform=CATransform3DMakeScale(0.8, 0.8, 1)
        })
    }
    
    /// 转场动画
    func changeScene(){
        UIView.transitionWithView(self.view, duration: 1, options: UIViewAnimationOptions.TransitionCurlUp, animations: nil, completion: nil)
    }
    
    // MARK: - 核心动画
    /// 创建图层
    func createLayer(){
        if(self.layer != nil){
            return
        }
        self.layer=CALayer()
        self.layer!.frame=CGRectMake(140, 80, 100, 100)
        self.layer!.backgroundColor=UIColor.redColor().CGColor
        // 注意 必须是CGImage
        self.layer!.contents=UIImage(named: "Stars")?.CGImage
        self.view.layer.addSublayer(self.layer!)
    }
    
    /// 隐式动画
    func animaLayer(){
        if(self.layer == nil){
            return
        }
        
        self.layer!.borderColor=UIColor.greenColor().CGColor
        self.layer!.borderWidth=CGFloat(arc4random_uniform(10)+UInt32(1))
        self.layer!.cornerRadius=CGFloat(arc4random_uniform(50))
        // 使用uiview里的超出layer的内容不显示
        self.layer!.masksToBounds=true
    }
    
    /// 基本动画
    func basicAnimation(){
        if(self.layer == nil){
            return
        }
        // 创建动画对象
        let anime=CABasicAnimation()
        
        // 设置动画的属性
        //anime.keyPath="position"
        anime.keyPath="transform.scale"
        
        // 设置属性改变的值
        //anime.toValue=NSValue(CGPoint: CGPointMake(200, 200))
        anime.toValue=0.5
        
        // 设置动画时长
        anime.duration=0.5
        // 重复次数
        anime.repeatCount=MAXFLOAT
        // 动画反转
        //anime.autoreverses=true
        // 取消反弹
        // 动画执行完毕之后不要把动画移除
        anime.removedOnCompletion=false
        
        // 保持最新的位置
        anime.fillMode=kCAFillModeForwards
        
        // 给图层添加动画
        self.layer!.addAnimation(anime, forKey: nil)
        
    }
    
    /// 路径动画
    func keyframeAnimation(){
        if(self.layer == nil){
            return
        }
        let anime=CAKeyframeAnimation()
        // 设置动画属性
        anime.keyPath="position"
        
        /*
        let v1=NSValue(CGPoint: CGPointZero)
        let v2=NSValue(CGPoint: CGPointMake(150, 200))
        let v3=NSValue(CGPoint: CGPointMake(300, 0))
        
        anime.values=[v1,v2,v3]
        */
        
        let path=UIBezierPath(ovalInRect: CGRectMake(100, 100, 200, 200))
        
        anime.path=path.CGPath
        anime.duration=2
        
        // 取消反弹
        // 动画执行完毕之后不要把动画移除
        anime.removedOnCompletion=false
        
        // 保持最新的位置
        anime.fillMode=kCAFillModeForwards
        
        self.layer!.addAnimation(anime, forKey: nil)
    }

    /// 动画组
    func animationGroup(){
        if(self.layer == nil){
            return
        }
        // 创建动画对象
        let scale=CABasicAnimation()
        
        // 设置动画的属性
        //anime.keyPath="position"
        scale.keyPath="transform.scale"
        
        // 设置属性改变的值
        //anime.toValue=NSValue(CGPoint: CGPointMake(200, 200))
        scale.toValue=0.5
        
        let position=CABasicAnimation()
        position.keyPath="position"
        position.toValue=NSValue(CGPoint: CGPointMake(150, 300))
        
        let group=CAAnimationGroup()
        group.animations=[scale,position]
        // 取消反弹
        // 动画执行完毕之后不要把动画移除
        group.removedOnCompletion=false
        // 保持最新的位置
        group.fillMode=kCAFillModeForwards
        // 设置动画时长
        group.duration=0.5
        // 重复次数
        group.repeatCount=MAXFLOAT
        
        self.layer!.addAnimation(group, forKey: nil)
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
