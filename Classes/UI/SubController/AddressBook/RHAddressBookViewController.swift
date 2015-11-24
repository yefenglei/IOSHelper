//
//  RHAddressBookViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/23.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit
import RHAddressBook

class RHAddressBookViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func getPeoples(sender: UIButton) {
        let allPeople = self.ab.people
        var content:String=""
        for person in allPeople{
            //NSLog("%@", person.description)
            content=content+person.description+"\r\n"
        }
        self.textView.text=content
    }

    var ab:RHAddressBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.创建通讯录
        self.ab = RHAddressBook()
        
        // 2.判断是否授权
        if(RHAddressBook.authorizationStatus()==RHAuthorizationStatus.NotDetermined){
            // 3.主动请求授权
            self.ab .requestAuthorizationWithCompletion({ (granted:Bool, error:NSError!) -> Void in
                if(granted){
                    NSLog("授权成功")
                }else{
                    NSLog("授权失败")
                }
            })
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
