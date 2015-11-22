//
//  LocalNotificationViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/22.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class LocalNotificationViewController: UIViewController {
    
    @IBAction func removeNote(sender: UIButton) {
        let app=UIApplication.sharedApplication()
        app.cancelAllLocalNotifications()
    }
    
    /*
    
    // timer-based scheduling
    @property(nonatomic,copy) NSDate *fireDate; 指定通知发送的时间
    @property(nonatomic,copy) NSTimeZone *timeZone; 指定发送通知的时区
    
    @property(nonatomic) NSCalendarUnit repeatInterval;  重复的周期, 枚举
    @property(nonatomic,copy) NSCalendar *repeatCalendar; 重复的周期  , 2014.12.12
    @property(nonatomic,copy) NSString *alertBody;      通知内容
    @property(nonatomic) BOOL hasAction;                是否需要华东事件
    @property(nonatomic,copy) NSString *alertAction;    锁屏状态的标题
    @property(nonatomic,copy) NSString *alertLaunchImage;   点击通知之后的启动图片
    @property(nonatomic,copy) NSString *soundName;    收到通知播放的音乐
    @property(nonatomic) NSInteger applicationIconBadgeNumber;  图标提醒数字
    @property(nonatomic,copy) NSDictionary *userInfo;   额外的信息
    */
    
    
    @IBAction func addNote(sender: UIButton) {
        // 1.创建本地通知对象
        let note=UILocalNotification()
        
        // 指定通知发送的时间(指定5秒之后发送通知)
        note.fireDate=NSDate(timeIntervalSinceNow: 5)
        // 注意: 在真实开发中一般情况下还需要指定时区(让通知的时间跟随当前时区)
        note.timeZone=NSTimeZone.defaultTimeZone()
        // 指定通知内容
        note.alertBody="这是通知内容"
        // 设置通知重复的周期(1分钟通知一期)
        //note.repeatInterval=NSCalendarUnit.Second
        
        // 指定锁屏界面的信息
        note.alertAction="这是锁屏界面信息"
        
        // 设置点击通知进入程序时候的启动图片
        //note.alertLaunchImage="Default"
        
        // 收到通知播放的音乐
        note.soundName="buyao.wav"
        
        // 设置应用程序的提醒图标
        note.applicationIconBadgeNumber=450
        
        // 注册通知时可以指定将来点击通知之后需要传递的数据
        note.userInfo=["name":"Tom","age":"22","phone":"13758113772"]
        // 2.注册通知(图片的名称建议使用应用程序启动的图片名称)
        let app=UIApplication.sharedApplication()
        // 每次调用添加方法都会将通知添加到scheduledLocalNotifications数组中
        app.scheduleLocalNotification(note)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
