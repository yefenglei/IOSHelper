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
                let itemPopover=ArrowCellItem(title: "Popover", icon: "MorePush", targetViewControllerName: "PopoverPresentationViewController")
                let itemAlertView=ArrowCellItem(title: "对话框", icon: "MorePush", targetViewControllerName: "AlertViewController")
        
                group.addCellItem(item1)
                group.addCellItem(item2)
                group.addCellItem(itemAddressBookUI)
                group.addCellItem(itemRHAddressBook)
                group.addCellItem(itemQRCode)
                group.addCellItem(itemSacnQRCode)
                group.addCellItem(itemPopover)
                group.addCellItem(itemAlertView)
                group.header="界面"
        
                // 组2
                let group2=CellGroup()
                let itemQuartz2D=ArrowCellItem(title: "Quartz2D简单使用", icon: "MorePush", targetViewControllerName: "Quartz2DViewController",useStoryboard: true)
                let itemPaintBoard=ArrowCellItem(title: "简单画图板", icon: "MorePush", targetViewControllerName: "PaintViewController",useStoryboard: true)
                let itemClock=ArrowCellItem(title: "时钟", icon: "MorePush", targetViewControllerName: "ClockViewController",useStoryboard: true)
                let itemGestureUnlock=ArrowCellItem(title: "手势解锁", icon: "MorePush", targetViewControllerName: "GestureUnlockViewController",useStoryboard: true)
                let itemCoreAnimation=ArrowCellItem(title: "核心动画", icon: "MorePush", targetViewControllerName: "CoreAnimationViewController")
                let itemTransition=ArrowCellItem(title: "自定义过场动画", icon: "MorePush", targetViewControllerName: "PopViewController",useStoryboard: true)
                // 将功能进行了封装，便于在其他项目中使用
                let itemCustomTransition=ArrowCellItem(title: "自定义过场动画2", icon: "MorePush", targetViewControllerName: "FirstModalViewController")
        
                let itemWaterFill=ArrowCellItem(title: "满水动画", icon: "MorePush", targetViewControllerName: "WaterFillViewController",useStoryboard: true)
                let itemCollectionView=ArrowCellItem(title: "UICollectionView相册动画", icon: "MorePush", targetViewControllerName: "CollectionViewController")
                let itemDragScale=ArrowCellItem(title: "图片下拉放大", icon: "MorePush", targetViewControllerName: "DragScalingViewController")
        
        
                group2.addCellItem(itemQuartz2D)
                group2.addCellItem(itemPaintBoard)
                group2.addCellItem(itemClock)
                group2.addCellItem(itemGestureUnlock)
                group2.addCellItem(itemCoreAnimation)
                group2.addCellItem(itemTransition)
                group2.addCellItem(itemCustomTransition)
                group2.addCellItem(itemWaterFill)
                group2.addCellItem(itemCollectionView)
                group2.addCellItem(itemDragScale)
        
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