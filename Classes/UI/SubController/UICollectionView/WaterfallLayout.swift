//
//  WaterfallLayout.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate:NSObjectProtocol{
    func waterflowLayout(waterflowLayout:WaterfallLayout,heightForWidth width:CGFloat,atIndexPath indexPath:NSIndexPath)->CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
    var sectionInset:UIEdgeInsets!
 /// 每一列之间的间距
    var columnMargin:CGFloat!
 /// 每一行之间的间距
    var rowMargin:CGFloat!
 /// 显示多少列
    var columnsCount:Int!
    
    var delegate:WaterfallLayoutDelegate!
 /// 这个字典用来存储每一列最大的Y值(每一列的高度)
    var maxYDict:Dictionary<String,CGFloat>!
 /// 存放所有的布局属性
    var attrsArray:[UICollectionViewLayoutAttributes]!
    
    
    override init() {
        super.init()
        self.columnMargin=10
        self.rowMargin=10
        self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10)
        self.columnsCount=3
        self.maxYDict=Dictionary<String,CGFloat>()
        self.attrsArray=[UICollectionViewLayoutAttributes]()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    
///  每次布局之前的准备
    override func prepareLayout() {
        super.prepareLayout()
        
        calculateAttrs()
        
    }
    
    
///  计算每个item的属性
    func calculateAttrs(){
        // 1.清空最大的Y值
        for i:Int in 0..<self.columnsCount{
            let column:String="\(i)"
            self.maxYDict[column]=self.sectionInset.top
        }
        
        // 2.计算所有cell的属性
        self.attrsArray.removeAll()
        let count=self.collectionView!.numberOfItemsInSection(0)
        for i:Int in 0..<count{
            let attrs=self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))
            self.attrsArray.append(attrs!)
        }
    }
    
    ///  返回所有的尺寸
    ///
    ///  - returns: collectionView的内容尺寸大小
    override func collectionViewContentSize() -> CGSize {
        var maxColumn:String="0"
        self.maxYDict.map { (dict:(key:String, value:CGFloat)) -> Void in
            if(dict.value>self.maxYDict[maxColumn]){
                maxColumn=dict.key
            }
        }
        return CGSizeMake(0, self.maxYDict[maxColumn]! + self.sectionInset.bottom)
    }
    
    ///  返回indexPath这个位置Item的布局属性
    ///
    ///  - parameter indexPath: Item的位置
    ///
    ///  - returns: Item的样式
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // 假设最短的那一列的第0列
        var minColumn:String="0"
        // 找出最短的那一列
        self.maxYDict.map { (dict:(key:String, value:CGFloat)) -> Void in
            if(dict.value<self.maxYDict[minColumn]){
                minColumn=dict.key
            }
        }
        // 计算尺寸
        let width:CGFloat=(self.collectionView!.frame.size.width - self.sectionInset.left - self.sectionInset.right - CGFloat(self.columnsCount - 1) * self.columnMargin)/CGFloat(self.columnsCount)
        let height:CGFloat=self.delegate.waterflowLayout(self, heightForWidth: width, atIndexPath: indexPath)
        
        // 计算位置
        let x:CGFloat = self.sectionInset.left + (width + self.columnMargin) * CGFloat((minColumn as NSString).floatValue)
        let y:CGFloat = self.maxYDict[minColumn]! + self.rowMargin
        
        // 更新这一列的最大Y值
        self.maxYDict[minColumn] = y+height
        
        // 创建属性
        let attrs=UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.frame=CGRectMake(x, y, width, height)
        return attrs
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
}
