//
//  CircleLayout.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/30.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CircleLayout: UICollectionViewLayout {

    ///  给每个item创建一个attribute
    ///
    ///  - parameter indexPath: indexPath description
    ///
    ///  - returns: attributes
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs=UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size=CGSizeMake(50, 50)
        
        // 园的半径
        let circleRadius:CGFloat=70
        let circleCenter:CGPoint=CGPointMake(self.collectionView!.frame.size.width*0.5, self.collectionView!.frame.size.height*0.5)
        // 每个item之间的角度
        let angleDelta = M_PI * 2 / Double(self.collectionView!.numberOfItemsInSection(indexPath.section))
        // 计算当前item的角度
        let angle:Float=Float(indexPath.item) * Float(angleDelta)
        
        attrs.center=CGPointMake(circleCenter.x+circleRadius*CGFloat(cosf(angle)), circleCenter.y-circleRadius*CGFloat(sinf(angle)))
        attrs.zIndex=indexPath.item
        return attrs
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrsArray=[UICollectionViewLayoutAttributes]()
        let count = self.collectionView!.numberOfItemsInSection(0)
        for i:Int in 0..<count{
            let attrs=self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))
            attrsArray.append(attrs!)
        }
        return attrsArray
    }
    
}
