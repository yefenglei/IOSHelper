//
//  Shop.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import Foundation

class Shop:NSObject {
    var w:NSNumber!
    var h:NSNumber!
    var img:String!
    var price:String!
    
    override init() {
        super.init()
    }
    
    init(dict:NSDictionary) {
        self.w=dict.valueForKey("w") as! NSNumber
        self.h=dict.valueForKey("h") as! NSNumber
        self.img=dict.valueForKey("img") as! String
        self.price=dict.valueForKey("price") as! String
    }
    
    static func Shops(shopArray:NSArray)->[Shop]{
        var shopList=[Shop]()
        for item in shopArray{
            shopList.append(Shop(dict: item as! NSDictionary))
        }
        return shopList
    }
}