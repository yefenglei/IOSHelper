//
//  AppDelegate.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/17.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 注意: 在iOS8中, 必须提前注册通知类型
        if #available(iOS 8.0, *){
            let type:UIUserNotificationType=[UIUserNotificationType.Alert,UIUserNotificationType.Badge,UIUserNotificationType.Sound]
            let settings=UIUserNotificationSettings(forTypes: type, categories: nil)
            // 注册通知类型
            application.registerUserNotificationSettings(settings)
        }
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        NSLog(" %@", notification.userInfo!)
        /*
        let label=UILabel()
        label.frame=CGRectMake(0, 250, 200, 200)
        label.numberOfLines=0;
        label.textColor=UIColor.wheatColor()
        label.text=NSString(format: " %@", notification.userInfo!) as String
        label.font=UIFont.systemFontOfSize(21)
        label.backgroundColor=UIColor.grayColor()
        self.window?.rootViewController!.view.addSubview(label)
        */
        application.applicationIconBadgeNumber=0
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

