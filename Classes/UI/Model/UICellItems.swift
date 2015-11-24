//
//  UICellItems.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/19.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

class UICellItems {
    static private var _dataList:[CellGroup]?
    static var dataList:[CellGroup]{
        get{
            if(self._dataList == nil){
                self._dataList=[CellGroup]()
                // 0组
                let group=CellGroup()
                let item1=ArrowCellItem(title: "本地通知", icon: "MorePush", targetViewControllerName: "LocalNotificationViewController")
                let item2=ArrowCellItem(title: "通讯录", icon: "MorePush", targetViewControllerName: "AddressBookViewController")
                let itemAddressBookUI=ArrowCellItem(title: "AddressBookUI基本使用", icon: "MorePush", targetViewControllerName: "AddressBookUIViewController")
                let itemRHAddressBook=ArrowCellItem(title: "集成RHAddressBookViewController", icon: "MorePush", targetViewControllerName: "RHAddressBookViewController")
        
                group.addCellItem(item1)
                group.addCellItem(item2)
                group.addCellItem(itemAddressBookUI)
                group.addCellItem(itemRHAddressBook)
                group.header="组1"
        
                self._dataList!.append(group)
            }
            return self._dataList!
        }
        set{
            self._dataList=newValue
        }
    }
}