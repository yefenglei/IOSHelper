//
//  StackLayout.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/30.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class StackLayout: UICollectionViewLayout {

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let angles:[CGFloat]=[0,-0.2,-0.5,0.2,0.5]
        let attrs=UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size=CGSizeMake(100, 100)
        attrs.center=CGPointMake(self.collectionView!.frame.size.width * 0.5, self.collectionView!.frame.size.height * 0.5)
        if(indexPath.item>=5){
            attrs.hidden=true
        }else{
            attrs.transform=CGAffineTransformMakeRotation(angles[indexPath.item])
            // zIndex越大，越在上面
            attrs.zIndex=self.collectionView!.numberOfItemsInSection(indexPath.section)-indexPath.item
        }
        return attrs
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrsArray:[UICollectionViewLayoutAttributes]=[UICollectionViewLayoutAttributes]()
        let count=self.collectionView!.numberOfItemsInSection(0)
        for i:Int in 0..<count{
            let attrs=self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))
            attrsArray.append(attrs!)
        }
        return attrsArray
    }
    
    
    
}
