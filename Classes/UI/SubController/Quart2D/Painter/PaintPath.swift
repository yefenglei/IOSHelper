//
//  PaintPath.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation

class PaintPath:UIBezierPath{
    var color:UIColor!
    
    init(lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint) {
        super.init()
        self.color=lineColor
        self.lineWidth=lineWidth
        self.moveToPoint(startPoint)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}