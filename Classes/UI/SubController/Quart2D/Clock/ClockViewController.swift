//
//  ClockViewController.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/1.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

enum ClockTimeType:Int{
    case Second=0,Minute,Hour
}

class ClockViewController: UIViewController {
    
    @IBOutlet weak var clockView: UIImageView!
    let perSecondAngle:Int=6
    let perMinuteAngle:Int=6
    let perHourAngle:Int=30
    let perHourperMinuteAngle:Float=0.5
    let perMinuteperSecondAngle:Float=0.1
    
    var secondLayer:CALayer!
    var minuteLayer:CALayer!
    var hourLayer:CALayer!
    var clockWidth:CGFloat!
    var clockHeight:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clockWidth=self.clockView.bounds.width
        self.clockHeight=self.clockView.bounds.height
        
        addSecondStick()
        addMinuteStick()
        addHourStick()
        
        let timer:NSTimer=NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 添加秒针
    func addSecondStick(){
        secondLayer=CALayer()
        // 1.设置锚点
        secondLayer.anchorPoint=CGPointMake(0.5, 1)
        // 2.设置起始位置
        secondLayer.position=CGPointMake(self.clockWidth/2, self.clockHeight/2)
        secondLayer.bounds=CGRectMake(0, 0, 1, self.clockHeight*0.5-20)
        // 3.设置背景颜色
        secondLayer.backgroundColor=UIColor.redColor().CGColor
        // 4.添加图层上
        self.clockView.layer.addSublayer(secondLayer)
    }
    
    /// 添加分针
    func addMinuteStick(){
        minuteLayer=CALayer()
        // 1.设置锚点
        minuteLayer.anchorPoint=CGPointMake(0.5, 1)
        // 2.设置起始位置
        minuteLayer.position=CGPointMake(self.clockWidth*0.5, self.clockHeight*0.5)
        minuteLayer.bounds=CGRectMake(0, 0, 2, clockHeight * 0.5-35)
        minuteLayer.cornerRadius=CGFloat(1)
        // 3.设置背景颜色
        minuteLayer.backgroundColor=UIColor.blueberryColor().CGColor
        // 4.添加到图层上
        self.clockView.layer.addSublayer(minuteLayer)
    }
    
    /// 添加时针
    func addHourStick(){
        hourLayer=CALayer()
        hourLayer.anchorPoint=CGPointMake(0.5, 1)
        hourLayer.position=CGPointMake(self.clockWidth*0.5, self.clockHeight*0.5)
        hourLayer.bounds=CGRectMake(0, 0, 4, clockHeight * 0.5-50)
        hourLayer.cornerRadius=CGFloat(4)
        hourLayer.backgroundColor=UIColor.blackColor().CGColor
        self.clockView.layer.addSublayer(hourLayer)
    }
    
    /// 刷新时钟时间，重新绘制
    func update(){
        // 1.获取日历对象
        let calender=NSCalendar.currentCalendar()
        // 2.获取日历组件
        let dateUnits:NSCalendarUnit=[NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second]
        let companents=calender.components(dateUnits, fromDate: NSDate())
        // 3.获取秒数 分钟数 小时数
        let sec:Int=companents.second
        let minute:Int=companents.minute
        let hour:Int=companents.hour
        
        let secondAngle:CGFloat=getAngle(sec, type: ClockTimeType.Second)
        var minuteAngle:CGFloat=getAngle(minute, type: ClockTimeType.Minute)
        minuteAngle += getMinuteAngelBySeconds(sec)
        var hourAngle:CGFloat=getAngle(hour, type: ClockTimeType.Hour)
        hourAngle += getHourAngleByMinutes(minute)
        
        secondLayer.transform=CATransform3DMakeRotation(secondAngle, 0, 0, 1)
        minuteLayer.transform=CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
        hourLayer.transform=CATransform3DMakeRotation(hourAngle, 0, 0, 1)
    }
    
    /// 获取对应指针旋转角度
    func getAngle(baseCount:Int,type:ClockTimeType)->CGFloat{
        var angle:Double=0
        var angleFlag:Int=perSecondAngle
        switch(type){
            case ClockTimeType.Second:
                angleFlag=perSecondAngle
            break
            case ClockTimeType.Minute:
                angleFlag=perMinuteAngle
            break
            case ClockTimeType.Hour:
                angleFlag=perHourAngle
            break
        }
        angle=Double(baseCount * angleFlag)/180.0 * M_PI
        return CGFloat(angle)
    }
    
    /// 根据分钟数获取对应的时针旋转角度
    func getHourAngleByMinutes(minutes:Int)->CGFloat{
        return CGFloat(Double(Float(minutes) * perHourperMinuteAngle/180.0) * M_PI)
    }
    
    /// 根据秒数获取对应的分针旋转角度
    func getMinuteAngelBySeconds(seconds:Int)->CGFloat{
        return CGFloat(Double(Float(seconds)*perMinuteperSecondAngle) * M_PI/180.0)
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
