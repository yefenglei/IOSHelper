//
//  NavigationViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/19.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    private var _lastVcView:UIImageView?
    var lastVcView:UIImageView!{
        get{
            if(self._lastVcView==nil){
                let window=UIApplication.sharedApplication().keyWindow!
                self._lastVcView=UIImageView()
                self._lastVcView!.frame=window.bounds
            }
            return self._lastVcView!
        }
        set{
            self._lastVcView=newValue
        }
    }
    
    private var _cover:UIView?
    var cover:UIView!{
        get{
            if(self._cover==nil){
                let window=UIApplication.sharedApplication().keyWindow!
                self._cover=UIView()
                self._cover!.frame=window.bounds
                self._cover!.backgroundColor=UIColor.blackColor()
                self._cover!.alpha=0.5
            }
            return self._cover!
        }
        set{
            self._cover=newValue
        }
    }
    
    /// 存放每一个控制器的全屏截图
    var images:[UIImage]=[UIImage]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        // 设置整个项目所有item的主题样式
        let barbuttom=UIBarButtonItem.appearance()
        // 设置不可用状态
        let disabledTextAttrs=[NSForegroundColorAttributeName:UIColor.grayColor(),NSFontAttributeName:UIFont.systemFontOfSize(15)]
        barbuttom.setTitleTextAttributes(disabledTextAttrs, forState: UIControlState.Disabled)
        // 设置普通状态
        let textAttrs=[NSForegroundColorAttributeName:UIColor.orangeColor(),NSFontAttributeName:UIFont.systemFontOfSize(15)]
        barbuttom.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 添加拖拽手势
        let recognizer=UIPanGestureRecognizer(target: self, action: Selector("dragging:"))
        self.view.addGestureRecognizer(recognizer)
    }
    
    func dragging(recognizer:UIPanGestureRecognizer){
        // 如果只有1个子控制器,停止拖拽
        if(self.viewControllers.count <= 1){
            return
        }
        // 在x方向上移动的距离
        let tx:CGFloat=recognizer.translationInView(self.view).x
        if(tx<0){
            // 往左滑，不做处理
            return
        }
        recognizer.state
        if((recognizer.state == UIGestureRecognizerState.Ended)||(recognizer.state == UIGestureRecognizerState.Cancelled)){
            // 决定pop还是还原
            let x:CGFloat=self.view.frame.origin.x
            if(x >= self.view.frame.size.width*0.5){
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0)
                    }, completion: { (finished:Bool) -> Void in
                        self.popViewControllerAnimated(false)
                        self.lastVcView.removeFromSuperview()
                        self.cover.removeFromSuperview()
                        self.view.transform=CGAffineTransformIdentity
                        self.images.removeLast()
                })
            }else{
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.transform=CGAffineTransformIdentity
                })
            }
        }else{
            // 移动view
            self.view.transform=CGAffineTransformMakeTranslation(tx, 0)
            
            let window=UIApplication.sharedApplication().keyWindow!
            // 添加截图到最后面
            self.lastVcView.image=self.images[self.images.count - 1]
            window.insertSubview(self.lastVcView, atIndex: 0)
            window.insertSubview(self.cover, aboveSubview: self.lastVcView)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @available(iOS 8.0, *)
    override func showViewController(vc: UIViewController, sender: AnyObject?) {
        
        self.createScreenShot()
        
        setNavigationBaseProperty(vc)
        
        // 跳转
        super.showViewController(vc, sender: sender)
        
        
    }

    /*
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        setNavigationBaseProperty(viewController)
        
        // 跳转
        super.pushViewController(viewController, animated: true)
        
        self.createScreenShot()
    }
    */
    
    
    ///  设置导航栏的默认属性
    ///
    ///  - parameter vc: 导航栏
    func setNavigationBaseProperty(vc: UIViewController){
        if(self.viewControllers.count == 0){
            // rootview 不给它设置uibarbutton
            return
        }
        // 隐藏底部tabbar
        vc.hidesBottomBarWhenPushed=true
        vc.navigationItem.leftBarButtonItem=UIBarButtonItem.itemWithTarget(self, action: "back:", image: "navigationbar_back", highlightImage: "navigationbar_back_highlighted")
        vc.navigationItem.rightBarButtonItem=UIBarButtonItem.itemWithTarget(self, action: "more:", image: "navigationbar_more", highlightImage: "navigationbar_more_highlighted")
    }
    
    /// back to last viewcontroller
    ///
    /// - parameter UIButton: button
    /// - returns: void
    func back(button:UIButton){
        self.popViewControllerAnimated(true)
        // 删除最后一张截图
        self.images.removeLast()
    }
    
    /// back to the rootViewController
    ///
    /// - parameter UIButton: button
    /// - returns: void
    func more(button:UIButton){
        self.popToRootViewControllerAnimated(true)
        // 删除所有截图
        self.images.removeAll()
    }
    
    // MARK: - 产生截图
    func createScreenShot(){
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.images.append(image)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        if(self.images.count>0){
//            return
//        }
//        self.createScreenShot()
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
