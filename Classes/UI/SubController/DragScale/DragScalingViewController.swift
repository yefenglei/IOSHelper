//
//  DragScalingViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/30.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class DragScalingViewController: UITableViewController {
    
    let TopViewH:CGFloat=350
    private var _topView:UIImageView?
    var topView:UIImageView{
        get{
            if(self._topView == nil){
                let tv=UIImageView()
                tv.image=UIImage(named: "biaoqingdi")
                tv.frame=CGRectMake(0, -TopViewH, 320, TopViewH)
                tv.contentMode=UIViewContentMode.ScaleAspectFill
                self._topView=tv
                return tv
            }
            return self._topView!
        }
        set{
            self._topView=newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame=UIScreen.mainScreen().bounds
        // 设置内边距(让cell往下移动一段距离)
        self.tableView.contentInset=UIEdgeInsetsMake(TopViewH*0.5, 0, 0, 0)
        self.tableView.insertSubview(self.topView, atIndex: 0)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId="cellId"
        var cell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier(cellId)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text="测试数据---\(indexPath.row)"
        return cell!
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // 向下拽了多少距离
        let down:CGFloat = -scrollView.contentOffset.y-TopViewH*0.5
        if(down<0){
            return
        }
        var frame:CGRect=self.topView.frame
        // 放大系数
        let scaleFactor:CGFloat=5
        frame.size.height = TopViewH+down*scaleFactor
        self.topView.frame=frame
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
