//
//  UIView+Extension.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/11/19.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    var x:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.origin.x=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    var y:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.origin.y=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    var centerX:CGFloat{
        set{
            var center:CGPoint=self.center
            center.x=newValue
            self.center=center
        }
        get{
            return self.center.x
        }
    }
    
    var centerY:CGFloat{
        set{
            var center:CGPoint=self.center
            center.y=newValue
            self.center=center
        }
        get{
            return self.center.y
        }
    }
    
    var width:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.size.width=newValue
            self.frame=frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    var height:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.size.height=newValue
            self.frame=frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    var size:CGSize{
        set{
            var frame:CGRect=self.frame
            frame.size=newValue
            self.frame=frame
        }
        get{
            return self.frame.size
        }
    }
    
    var origin:CGPoint{
        set{
            var frame:CGRect=self.frame
            frame.origin=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin
        }
    }
}