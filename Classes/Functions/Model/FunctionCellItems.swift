//
//  FunctionCellItems.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/5.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import Foundation
class FunctionCellItems {
    static private var _dataList:[CellGroup]?
    static var dataList:[CellGroup]{
        get{
        if(self._dataList == nil){
        self._dataList=[CellGroup]()
        // 0组
        let group=CellGroup()
        let itemQRCode=ArrowCellItem(title: "生成二维码", icon: "MorePush", targetViewControllerName: "QRCodeViewController")
        let itemSacnQRCode=ArrowCellItem(title: "扫二维码", icon: "MorePush", targetViewControllerName: "ScanQRCodeViewController")
        
        group.addCellItem(itemQRCode)
        group.addCellItem(itemSacnQRCode)
        group.header="基本功能"

        self._dataList!.append(group)
        }
        return self._dataList!
        }
        set{
            self._dataList=newValue
        }
    }
}