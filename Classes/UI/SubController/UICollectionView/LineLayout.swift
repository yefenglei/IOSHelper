//
//  LineLayout.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {

    // 定义物体的宽高
    let itemWH:CGFloat=100
    
    /**
     *  只要显示的边界发生改变就重新布局:
     内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
     */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    /**
     *  用来设置collectionView停止滚动那一刻的位置
     *
     *  @param proposedContentOffset 原本collectionView停止滚动那一刻的位置
     *  @param velocity              滚动速度
     */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // 1.计算出scrollView最后会停留的范围
        var lastRect=CGRect()
        lastRect.origin=proposedContentOffset
        lastRect.size=self.collectionView!.frame.size
        
        // 计算屏幕最中间的x
        let centerX:CGFloat=proposedContentOffset.x+self.collectionView!.frame.size.width*0.5
        
        // 2.取出这个范围内的所有属性
        let attributes=self.layoutAttributesForElementsInRect(lastRect)
        
        // 3.遍历所有属性
        var adjustOffsetX=CGFloat.max
        if(attributes != nil){
            for attr in attributes!{
                if(abs(attr.center.x - centerX)<abs(adjustOffsetX)){
                    adjustOffsetX=attr.center.x - centerX
                }
            }
            return CGPointMake(proposedContentOffset.x+adjustOffsetX, proposedContentOffset.y)
        }else{
            return CGPoint.zero
        }
        
    }
    
    /// 初始化工作在这里实现
    override func prepareLayout() {
        super.prepareLayout()
        
        // 每个cell的尺寸
        self.itemSize=CGSizeMake(itemWH, itemWH)
        let inset:CGFloat=(self.collectionView!.frame.size.width-itemWH)*0.5
        self.sectionInset=UIEdgeInsetsMake(0,inset,0,inset)
        // 设置水平滚动
        self.scrollDirection=UICollectionViewScrollDirection.Horizontal
        self.minimumLineSpacing=itemWH*0.7
        
        // 每一个cell(item)都有自己的UICollectionViewLayoutAttributes
        // 每一个indexPath都有自己的UICollectionViewLayoutAttributes
    }
    /** 有效距离:当item的中间x距离屏幕的中间x在HMActiveDistance以内,才会开始放大, 其它情况都是缩小 */
    let ActiveDistance:CGFloat=150
    /** 缩放因素: 值越大, item就会越大 */
    let ScaleFactor:CGFloat=0.6
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 0.计算可见的矩形框
        var visiableRect=CGRect()
        visiableRect.size=self.collectionView!.frame.size
        visiableRect.origin=self.collectionView!.contentOffset
        
        // 1.取得默认的cell的UICollectionViewLayoutAttributes
        let attributes = super.layoutAttributesForElementsInRect(rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            // add the changes to the itemAttributesCopy
            attributesCopy.append(itemAttributesCopy)
        }
        // 计算屏幕最中间的x
        let centerX=self.collectionView!.contentOffset.x+self.collectionView!.frame.size.width * 0.5
        
        // 2.遍历所有的布局属性
        for attr in attributesCopy{
            // 如果不在屏幕上，直接跳过
            if(!CGRectIntersectsRect(visiableRect, attr.frame)){
                continue
            }
            // 每一个item的中点x
            let itemCenterX=attr.center.x
            
            // 差距越小, 缩放比例越大
            // 根据跟屏幕最中间的距离计算缩放比例
            let scale=1 + ScaleFactor*(1-abs(itemCenterX-centerX)/ActiveDistance)
            attr.transform=CGAffineTransformMakeScale(scale, scale)
        }
        
        return attributesCopy
    }
}
