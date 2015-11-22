//
//  AddressBookViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/21.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit
import AddressBook

class AddressBookViewController: UIViewController {
    
    @IBAction func addNewRecord(sender: UIButton) {
        // 判断是否授权成功
        if(ABAddressBookGetAuthorizationStatus() != ABAuthorizationStatus.Authorized){
            // 授权失败直接返回
            return;
        }
        // 1.创建联系人
        let people=ABPersonCreate().takeRetainedValue()
        
        // 2.设置联系人信息
        ABRecordSetValue(people, kABPersonLastNameProperty, "牛", nil)
        ABRecordSetValue(people, kABPersonFirstNameProperty, "查", nil)
        
        // 创建电话号码
        let phones=ABMultiValueCreateMutable(UInt32(kABMultiStringPropertyType)).takeRetainedValue()
        ABMultiValueAddValueAndLabel(phones, "123456789", kABPersonPhoneMainLabel, nil)
        ABMultiValueAddValueAndLabel(phones, "8888888", kABPersonPhoneHomeFAXLabel, nil)
        ABRecordSetValue(people, kABPersonPhoneProperty, phones, nil)

        // 3.拿到通讯录
        let book:ABAddressBook=ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        // 4.将联系人添加到通讯录中
        ABAddressBookAddRecord(book, people, nil)
        // 5.保存通讯录
        ABAddressBookSave(book, nil)
        
        MBProgressHUD.showSuccess("添加成功")
        self.hideMB(1)
    }
    
    @IBAction func updateRecord(sender: UIButton) {
        // 判断是否授权成功
        if(ABAddressBookGetAuthorizationStatus() != ABAuthorizationStatus.Authorized){
            // 授权失败直接返回
            return;
        }
        // 1.创建通讯录对象
        let book:ABAddressBook=ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        // 2.获取通讯录中得所有联系人
        let allPeople:CFArrayRef=ABAddressBookCopyArrayOfAllPeople(book).takeRetainedValue()
        
        // 3.取出其中的一个联系人
        let peopleObj=CFArrayGetValueAtIndex(allPeople, 0)
        let people:ABRecordRef=unsafeBitCast(peopleObj, ABRecordRef.self)
        
        // 4.修改联系人信息
        ABRecordSetValue(people, kABPersonLastNameProperty, "test", nil)
        
        // 5.保存修改之后的信息
        ABAddressBookSave(book, nil)
        
        MBProgressHUD.showSuccess("保存成功")
        self.hideMB(1)
        
    }
    @IBOutlet weak var textview: UITextView!
    
    @IBAction func getAddressBookClicked(sender: UIButton) {
        // 判断是否授权成功
        if(ABAddressBookGetAuthorizationStatus() != ABAuthorizationStatus.Authorized){
            // 授权失败直接返回
            return;
        }
        // 1.创建通讯录对象
        let book:ABAddressBook=ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        // 2.获取通讯录中得所有联系人
        let allPeople:CFArrayRef=ABAddressBookCopyArrayOfAllPeople(book).takeRetainedValue()
        
        let count=CFArrayGetCount(allPeople)
        
        var content:String=""
        // 3.打印每一个联系人额信息
        for i:Int in 0..<count{
            // 联系人列表中的每一个人都是一个ABrecordRef
            let peopleObj=CFArrayGetValueAtIndex(allPeople, i)
            let people:ABRecordRef=unsafeBitCast(peopleObj, ABRecordRef.self)
            
            // 取出当前联系人的的电话信息
            // 获取联系人的姓名
            let lastName=ABRecordCopyValue(people, kABPersonLastNameProperty)
            let firstName=ABRecordCopyValue(people, kABPersonFirstNameProperty)
            if(firstName != nil){
                content=content+"\(firstName) "
            }
            if(lastName != nil){
                content=content+"\(lastName) \r\n"
            }
            // 获取联系人的电话
            // 从联系人中获取到得电话是所有的电话
            let phones:ABMultiValueRef=ABRecordCopyValue(people, kABPersonPhoneProperty).takeRetainedValue()
            // 获取当前联系人总共有多少种电话
            let phoneCount:CFIndex=ABMultiValueGetCount(phones)
            
            for i:Int in 0..<phoneCount{
                let name:CFStringRef = ABMultiValueCopyLabelAtIndex(phones, i).takeRetainedValue()
                // 从所有的电话中取出指定的电话
                let value:CFStringRef =  ABMultiValueCopyValueAtIndex(phones, i).takeRetainedValue() as! CFStringRef
                content=content+"name = \(name) value = \(value) \r\n"
            }
            textview.text=content
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 判断是否授权成功
        if(ABAddressBookGetAuthorizationStatus()==ABAuthorizationStatus.Authorized){
            // 授权成功直接返回
            return
        }
        
        // 0.创建通讯录
        let book=ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        
        // 1.请求用户授权
        // 第一个参数接收通讯录
        // 第二个参数是一个block, 无论授权成功还是失败都会调用
        ABAddressBookRequestAccessWithCompletion(book) { (granted:Bool, error:CFError!) -> Void in
            // granted true 代表用户授权成功 false 代表用户授权失败
            if(granted){
                MBProgressHUD.showSuccess("授权成功")
                self.hideMB(1)
            }else{
                MBProgressHUD.showSuccess("授权失败")
                self.hideMB(1)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func hideMB(delay:Int){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC  * 1000 * UInt64(delay))), dispatch_get_main_queue(), { () -> Void in
            MBProgressHUD.hideHUD()
        })
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
