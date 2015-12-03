//
//  NetworkCellItems.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/2.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

class NetworkCellItems {
    static private var _dataList:[CellGroup]?
    static var dataList:[CellGroup]{
        get{
        if(self._dataList == nil){
        self._dataList=[CellGroup]()
        // 0组
        let group=CellGroup()
        let itemNativeNetwork=ArrowCellItem(title: "IOS自带的网络请求", icon: "MorePush", targetViewControllerName: "NativeNetworkViewController",useStoryboard: true)
        let itemLocalNetwork=ArrowCellItem(title: "本地网络状态", icon: "MorePush", targetViewControllerName: "LocalNetworkStatusViewController")
        let itemSessionNetwork=ArrowCellItem(title: "NSURLSession", icon: "MorePush", targetViewControllerName: "SessionNetworkViewController")
        
        group.addCellItem(itemNativeNetwork)
        group.addCellItem(itemLocalNetwork)
        group.addCellItem(itemSessionNetwork)
        
        group.header="网络"
        
        
        self._dataList!.append(group)
        
        }
        return self._dataList!
        }
        set{
            self._dataList=newValue
        }
    }

}