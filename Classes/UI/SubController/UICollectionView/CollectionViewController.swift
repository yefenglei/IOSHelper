//
//  CollectionViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var images:[String]=[String]()
    weak var collectionView:UICollectionView!
    let cellId="imageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 如果使用了navigationcontroller，则必须加，不然contentoffset.y会自动-64，这样会影响后面的布局
        self.automaticallyAdjustsScrollViewInsets=false
        
        self.view.backgroundColor=UIColor.whiteColor()
        self.view.bounds=UIScreen.mainScreen().bounds
        
        // 初始化相册
        for i:Int in 1...20{
            self.images.append(i.description)
        }
        
        let w=self.view.frame.size.width
        let rect=CGRectMake(0, 100, w, 200)
        // 设置流水线样式
        let collectionView=UICollectionView(frame: rect, collectionViewLayout: LineLayout())
        collectionView.dataSource=self
        collectionView.delegate=self
        collectionView.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
        self.collectionView=collectionView
        
        // 添加样式切换按钮
        let button=UIButton(frame: CGRectMake(100, 350, 100, 24))
        button.setTitle("切换样式", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("changeStyle:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    
    func changeStyle(button:UIButton){
        if(self.collectionView.collectionViewLayout.isKindOfClass(LineLayout.self)){
            // 切换为系统默认的流水布局
            self.collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        }else{
            self.collectionView.setCollectionViewLayout(LineLayout(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ImageCell
        cell.image=self.images[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 删除点击的相片
        self.images.removeAtIndex(indexPath.item)
        // 刷新UI
        collectionView.deleteItemsAtIndexPaths([indexPath])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
