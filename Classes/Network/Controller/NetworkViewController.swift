//
//  NetworkViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/2.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class NetworkViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="网络"
        self.setDataList(NetworkCellItems.dataList)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
