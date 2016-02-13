//
//  MBProgressHUD+Extension.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/2.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

extension MBProgressHUD{
    ///  显示消息提示
    ///
    ///  - parameter message:  消息内容
    ///  - parameter duration: 持续时间，毫秒
    static func showMessage(message:String,duration:UInt64){
        MBProgressHUD.showMessage(message)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(duration*NSEC_PER_MSEC)), dispatch_get_main_queue()) { () -> Void in
            MBProgressHUD.hideHUD()
        }
    }
}