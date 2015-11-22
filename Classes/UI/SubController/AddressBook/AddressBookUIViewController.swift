//
//  AddressBookUIViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/22.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit
import AddressBookUI

class AddressBookUIViewController: UIViewController,ABPeoplePickerNavigationControllerDelegate {
    // MARK: - warning 注意, 通讯录控制器的代理不是delegate, 而是peoplePickerDelegate
    @IBAction func btnClicked(sender: UIButton) {
        let vc=ABPeoplePickerNavigationController()
        vc.peoplePickerDelegate=self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 在iOS7时 点击cancle按钮时候就会调用
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController) {
        // 关闭通讯录
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    //  在iOS7时 , 选中某一个联系人就会调用
    // 返回一个BOOL值, 如果返回NO, 代表不会进入下一层(详情), 如果返回YES,代表会进入下一层
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord) -> Bool {
        /*
        //取出当前联系人的的电话信息
        // 获取练习人得姓名
        CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@ %@", firstName, lastName);
        // 获取联系人的电话
        // 从联系人中获取到得电话是所有的电话
        ABMultiValueRef phones =   ABRecordCopyValue(person, kABPersonPhoneProperty);
        // 获取当前联系人总共有多少种电话
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        
        for (int i = 0; i < phoneCount; i++) {
        CFStringRef name = ABMultiValueCopyLabelAtIndex(phones, i);
        // 从所有的电话中取出指定的电话
        CFStringRef value =  ABMultiValueCopyValueAtIndex(phones, i);
        NSLog(@"name = %@ value = %@", name, value);
        }
        */
        return true
    }
    
    //  在iOS7时 , 选中某一个联系人的某一个属性时就会调用
    // 返回一个BOOL值, 如果返回NO, 代表不会进行下一步操作(打电话, 打开日历....), 如果返回YES,代表会进行下一步操作
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, shouldContinueAfterSelectingPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return true
    }
    
    // MARK: - iOS8
    // MARK: - 只要实现了这个方法, 就不会进行下一步操作(进入详情), iOS8的做法是默认返回NO
    /*
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        
    }
    */
    // 选中某一个联系人的某一个属性时就会调用
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
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
