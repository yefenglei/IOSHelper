//
//  PopDetailViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/13.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

public protocol PopDetailViewControllerDelegate : NSObjectProtocol {
    func showOriginImage()
}

class PopDetailViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var licenseButton: UIButton!
    @IBOutlet var authorButton: UIButton!
    
    var herb: HerbModel!
    var imageDelegate:PopDetailViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bgImage.image = UIImage(named: herb.image)
        titleView.text = herb.name
        descriptionView.text = herb.description
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("actionClose:")))
    }
    
    func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            if(self.imageDelegate != nil && self.imageDelegate!.respondsToSelector(Selector("showOriginImage"))){
                self.imageDelegate!.showOriginImage()
            }
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: button actions
    
    @IBAction func actionLicense(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: herb!.license)!)
    }
    
    @IBAction func actionAuthor(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: herb!.credit)!)
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
