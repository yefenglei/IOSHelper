//
//  WaterfallViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WaterfallViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,WaterfallLayoutDelegate {
    
    lazy var shops:[Shop]=[Shop]()
    var collectionView:UICollectionView!
    let ID:String="shop"

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.初始化数据
        let url = NSBundle.mainBundle().URLForResource("waterfall", withExtension: "plist")!
        let shopArr = NSArray(contentsOfURL: url)!
        //let shopArray=Shop.objectArrayWithFilename("waterfall.plist")
        let shopArray =  Shop.Shops(shopArr)
        for item in shopArray{
            self.shops.append(item)
        }
        
        let waterfallLayout=WaterfallLayout()
        waterfallLayout.delegate=self
        self.view.bounds=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        // 2.设置collectionview属性
        self.collectionView=UICollectionView(frame: self.view.bounds, collectionViewLayout: waterfallLayout)
        self.collectionView.backgroundColor=UIColor.whiteColor()
        self.collectionView.registerNib(UINib(nibName: "WaterfallCell", bundle: nil), forCellWithReuseIdentifier: ID)
        self.collectionView.delegate=self
        self.collectionView.dataSource=self
        self.view.addSubview(self.collectionView)
        // 3.增加刷新控件
        self.collectionView.mj_footer=MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreShops"))
        
        
    }
    
    func loadMoreShops(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 / 2 * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            
            // 1.初始化数据
            let url = NSBundle.mainBundle().URLForResource("waterfall", withExtension: "plist")!
            let shopArr = NSArray(contentsOfURL: url)!
            let shopArray =  Shop.Shops(shopArr)
            for item in shopArray{
                self.shops.append(item)
            }
            self.collectionView.reloadData()
            self.collectionView.mj_footer.endRefreshing()

            /*
            // 1.初始化数据
            let shopArray=Shop.objectArrayWithFilename("waterfall.plist") as! [Shop]
            for item in shopArray{
                self.shops.append(item)
            }
            self.collectionView.reloadData()
            self.collectionView.mj_footer.endRefreshing()
            */
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.shops.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! WaterfallCell
    
        cell.shop=self.shops[indexPath.item]
    
        return cell
    }
    
    // MARK: WaterfallLayoutDelegate
    func waterflowLayout(waterflowLayout: WaterfallLayout, heightForWidth width: CGFloat, atIndexPath indexPath: NSIndexPath) -> CGFloat {
        let shop:Shop=self.shops[indexPath.item]
        return CGFloat(shop.h.floatValue) / CGFloat(shop.w.floatValue) * width
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
