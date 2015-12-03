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
                let item1=ArrowCellItem(title: "本地通知", icon: "MorePush", targetViewControllerName: "LocalNotificationViewController",useStoryboard: true)
                let item2=ArrowCellItem(title: "通讯录", icon: "MorePush", targetViewControllerName: "AddressBookViewController",useStoryboard: true)
                let itemAddressBookUI=ArrowCellItem(title: "AddressBookUI基本使用", icon: "MorePush", targetViewControllerName: "AddressBookUIViewController",useStoryboard: true)
                let itemRHAddressBook=ArrowCellItem(title: "集成RHAddressBookViewController", icon: "MorePush", targetViewControllerName: "RHAddressBookViewController")
                let itemQRCode=ArrowCellItem(title: "生成二维码", icon: "MorePush", targetViewControllerName: "QRCodeViewController")
                let itemSacnQRCode=ArrowCellItem(title: "扫二维码", icon: "MorePush", targetViewControllerName: "ScanQRCodeViewController")
                group.addCellItem(item1)
                group.addCellItem(item2)
                group.addCellItem(itemAddressBookUI)
                group.addCellItem(itemRHAddressBook)
                group.addCellItem(itemQRCode)
                group.addCellItem(itemSacnQRCode)
                group.header="界面"
        
                // 组2
                let group2=CellGroup()
                let itemQuartz2D=ArrowCellItem(title: "Quartz2D简单使用", icon: "MorePush", targetViewControllerName: "Quartz2DViewController",useStoryboard: true)
                let itemPaintBoard=ArrowCellItem(title: "简单画图板", icon: "MorePush", targetViewControllerName: "PaintViewController",useStoryboard: true)
                let itemClock=ArrowCellItem(title: "时钟", icon: "MorePush", targetViewControllerName: "ClockViewController",useStoryboard: true)
                let itemGestureUnlock=ArrowCellItem(title: "手势解锁", icon: "MorePush", targetViewControllerName: "GestureUnlockViewController",useStoryboard: true)
        
                group2.addCellItem(itemQuartz2D)
                group2.addCellItem(itemPaintBoard)
                group2.addCellItem(itemClock)
                group2.addCellItem(itemGestureUnlock)
                group2.header="动画"
        
                self._dataList!.append(group)
                self._dataList!.append(group2)
            }
            return self._dataList!
        }
        set{
            self._dataList=newValue
        }
    }
}