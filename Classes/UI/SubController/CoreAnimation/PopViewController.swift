//
//  PopViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/13.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class PopViewController: UIViewController,UIScrollViewDelegate,UIViewControllerTransitioningDelegate,PopDetailViewControllerDelegate {
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var listView: UIScrollView!
    var selectedImage:UIImageView?
    
    // 加载全部模型数据
    let herbs=HerbModel.all()
    // 转场动画
    let transition=PopAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if listView.subviews.count<herbs.count{
            listView.viewWithTag(0)?.tag = 1000 //prevent confusion when looking up images
            setupList()
        }
    }
    
    /// 将所有的image添加到scrollView中
    func setupList(){
        // 计算并设置list中各个元素的位置
        let ratio=view.frame.size.height / view.frame.size.width
        let itemHeight: CGFloat = listView.frame.height * 1.33
        let itemWidth: CGFloat = itemHeight / ratio
        let horizontalPadding: CGFloat = 10.0
        
        for i:Int in 0..<herbs.count{
            // 创建iamgeview
            let imageView=UIImageView(image: UIImage(named: herbs[i].image))
            imageView.tag=i
            imageView.contentMode = .ScaleAspectFit
            imageView.userInteractionEnabled=true
            imageView.layer.cornerRadius=20
            imageView.layer.masksToBounds = true
            // 设置每个imageview的大小和位置
            imageView.frame=CGRectMake(CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, 0, itemWidth, itemHeight)
            listView.addSubview(imageView)
            
            // 添加tap手势
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapImageView:")))
        }
        // 设置整个scrollview的内容宽度
        listView.contentSize=CGSizeMake(CGFloat(herbs.count) * (itemWidth + horizontalPadding) + horizontalPadding, 0)
        listView.backgroundColor=UIColor.clearColor()

    }
    
    func didTapImageView(tap: UITapGestureRecognizer){
        self.selectedImage=tap.view as? UIImageView
        
        let index = tap.view!.tag
        let selectedHerb = herbs[index]
        
        // 跳转到详细页面
        let popDetails = storyboard!.instantiateViewControllerWithIdentifier("PopDetailViewController") as! PopDetailViewController
        popDetails.herb = selectedHerb
        popDetails.transitioningDelegate = self
        popDetails.imageDelegate=self
        presentViewController(popDetails, animated: true, completion: nil)
        
        hideOriginImage()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame=self.selectedImage!.superview!.convertRect(self.selectedImage!.frame, toView: nil)
        transition.presenting=true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting=false
        return transition
    }
    /// 隐藏选中的imageview
    func hideOriginImage(){
        self.selectedImage?.hidden=true
    }
    /// 显示选中图片
    func showOriginImage() {
        self.selectedImage?.hidden=false
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
