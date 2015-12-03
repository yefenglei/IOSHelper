//
//  ThreadsCellItems.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/1.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

class ThreadsCellItems {
    static private var _dataList:[CellGroup]?
    static var dataList:[CellGroup]{
        get{
        if(self._dataList == nil){
        self._dataList=[CellGroup]()
        // 0组
        let group=CellGroup()
        let item1=ArrowCellItem(title: "GCD多线程", icon: "MorePush", targetViewControllerName: "GCDViewController",useStoryboard: true)
        
        group.addCellItem(item1)

        group.header="多线程"
        
        
        self._dataList!.append(group)

        }
        return self._dataList!
        }
        set{
            self._dataList=newValue
        }
    }
}