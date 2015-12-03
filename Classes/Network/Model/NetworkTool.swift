//
//  NetworkTool.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/3.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

class NetworkTool {
    
    /// 判断手机信号是不是2G或3G
    static func isEnable3G()->Bool{
        // 1.获取reachability对象
        let wifi:Reachability=Reachability.reachabilityForInternetConnection()
        // 2.获得Reachability对象的当前网络状态
        
        let wifiStatus=wifi.currentReachabilityStatus()
        if(wifiStatus.rawValue == ReachableViaWWAN.rawValue){
            return true
        }else{
            return false
        }
    }
    
    /// 判断手机网络是不是wifi
    static func isEnableWifi()->Bool{
        // 1.获取reachability对象
        let wifi:Reachability=Reachability.reachabilityForLocalWiFi()
        // 2.获得Reachability对象的当前网络状态
        let wifiStatus=wifi.currentReachabilityStatus()
        
        return (wifiStatus.rawValue == ReachableViaWiFi.rawValue)
    }
    
    
}