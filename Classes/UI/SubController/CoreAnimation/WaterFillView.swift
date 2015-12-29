//
//  WaterFillView.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/23.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class WaterFillView: UIView {

    var updateLayerValueForCompletedAnimation : Bool = false
    var animationAdded : Bool = false
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var layers : Dictionary<String, AnyObject> = [:]
    
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
        addOldAnimation()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
        addOldAnimation()
    }
    
    var oldAnimProgress: CGFloat = 0{
        didSet{
            if(!self.animationAdded){
                removeAllAnimations()
                addOldAnimation()
                self.animationAdded = true
                layer.speed = 0
                layer.timeOffset = 0
            }
            else{
                let totalDuration : CGFloat = 2.41
                let offset = oldAnimProgress * totalDuration
                layer.timeOffset = CFTimeInterval(offset)
            }
        }
    }
    
    func setupProperties(){
        
    }
    
    func setupLayers(){
        let water = CALayer()
        water.anchorPoint     = CGPointMake(0.5, 1)
        water.frame           = CGRectMake(49.5, 214.5, 150.42, 1)
        water.backgroundColor = UIColor(red:0.376, green: 0.784, blue:0.906, alpha:1).CGColor
        self.layer.addSublayer(water)
        layers["water"] = water
        let path = CAShapeLayer()
        path.frame     = CGRectMake(0.16, -37.6, 150.68, 38.21)
        path.fillColor = UIColor(red:0.376, green: 0.784, blue:0.906, alpha:1).CGColor
        path.lineWidth = 0
        path.path      = pathPath().CGPath;
        water.addSublayer(path)
        layers["path"] = path
        let path2 = CAShapeLayer()
        path2.hidden    = true
        path2.frame     = CGRectMake(-97.03, 33.85, 150.68, 35.57)
        path2.fillColor = UIColor(red:0.243, green: 0.584, blue:0.725, alpha:1).CGColor
        path2.lineWidth = 0
        path2.path      = path2Path().CGPath;
        water.addSublayer(path2)
        layers["path2"] = path2
        let path3 = CAShapeLayer()
        path3.hidden    = true
        path3.frame     = CGRectMake(-81.05, 6.69, 150.68, 41.61)
        path3.fillColor = UIColor(red:0.243, green: 0.584, blue:0.725, alpha:1).CGColor
        path3.lineWidth = 0
        path3.path      = path3Path().CGPath;
        water.addSublayer(path3)
        layers["path3"] = path3
        
        let rectangle = CAShapeLayer()
        rectangle.frame       = CGRectMake(50, 35, 150, 180)
        rectangle.fillColor   = nil
        rectangle.strokeColor = UIColor(red:0.329, green: 0.329, blue:0.329, alpha:1).CGColor
        rectangle.lineWidth   = 2
        rectangle.path        = rectanglePath().CGPath;
        self.layer.addSublayer(rectangle)
        layers["rectangle"] = rectangle
    }
    
    
    
    //MARK: - Animation Setup
    
    func addOldAnimation(){
        addOldAnimationCompletionBlock(nil)
    }
    
    func addOldAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 2.63
            completionAnim.delegate = self
            completionAnim.setValue("old", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"old")
            if let anim = layer.animationForKey("old"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        ////Water animation
        let waterBoundsAnim       = CABasicAnimation(keyPath:"bounds")
        waterBoundsAnim.fromValue = NSValue(CGRect: CGRectMake(0, 0, 150, 1));
        waterBoundsAnim.toValue   = NSValue(CGRect: CGRectMake(0, 0, 150, 160));
        waterBoundsAnim.duration  = 2.06
        
        let waterOldAnim : CAAnimationGroup = QCMethod.groupAnimations([waterBoundsAnim], fillMode:fillMode)
        layers["water"]?.addAnimation(waterOldAnim, forKey:"waterOldAnim")
        
        ////Path animation
        let pathPathAnim          = CAKeyframeAnimation(keyPath:"path")
        pathPathAnim.values       = [QCMethod.alignToBottomPath(pathPath(), layer:layers["path"] as! CALayer).CGPath, QCMethod.alignToBottomPath(path2Path(), layer:layers["path"] as! CALayer).CGPath, QCMethod.alignToBottomPath(path3Path(), layer:layers["path"] as! CALayer).CGPath]
        pathPathAnim.keyTimes     = [0, 0.486, 1]
        pathPathAnim.duration     = 0.438
        pathPathAnim.repeatCount  = 3
        pathPathAnim.autoreverses = true
        
        let pathTransformAnim          = CAKeyframeAnimation(keyPath:"transform")
        pathTransformAnim.values       = [NSValue(CATransform3D: CATransform3DIdentity),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeTranslation(2, 12, 0), CATransform3DMakeRotation(9 * CGFloat(M_PI/180), 0, -0, 1))),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeTranslation(-3, 14, 0), CATransform3DMakeRotation(-7 * CGFloat(M_PI/180), -0, 0, 1)))]
        pathTransformAnim.keyTimes     = [0, 0.478, 1]
        pathTransformAnim.duration     = 0.788
        pathTransformAnim.beginTime    = 0.43
        pathTransformAnim.autoreverses = true
        
        let pathPositionAnim       = CABasicAnimation(keyPath:"position")
        pathPositionAnim.fromValue = NSValue(CGPoint: CGPointMake(75.5, -18.5));
        pathPositionAnim.toValue   = NSValue(CGPoint: CGPointMake(74.5, 18.5));
        pathPositionAnim.duration  = 1.19
        pathPositionAnim.beginTime = 1.22
        
        let pathOldAnim : CAAnimationGroup = QCMethod.groupAnimations([pathPathAnim, pathTransformAnim, pathPositionAnim], fillMode:fillMode)
        layers["path"]?.addAnimation(pathOldAnim, forKey:"pathOldAnim")
    }
    
    //MARK: - Animation Cleanup
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValueForKey(anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
                removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValuesForAnimationId(identifier: String){
        if identifier == "old"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["water"] as! CALayer).animationForKey("waterOldAnim"), theLayer:(layers["water"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["path"] as! CALayer).animationForKey("pathOldAnim"), theLayer:(layers["path"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "old"{
            (layers["water"] as! CALayer).removeAnimationForKey("waterOldAnim")
            (layers["path"] as! CALayer).removeAnimationForKey("pathOldAnim")
        }
        self.layer.speed = 1
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
        self.layer.speed = 1
    }
    
    //MARK: - Bezier Path
    
    func pathPath() -> UIBezierPath{
        let pathPath = UIBezierPath()
        pathPath.moveToPoint(CGPointMake(1.326, 37.628))
        pathPath.addCurveToPoint(CGPointMake(3.239, 5.332), controlPoint1:CGPointMake(-0.931, 24.693), controlPoint2:CGPointMake(-0.315, 6.703))
        pathPath.addCurveToPoint(CGPointMake(38.084, 5.332), controlPoint1:CGPointMake(6.793, 3.962), controlPoint2:CGPointMake(16.214, -5.948))
        pathPath.addCurveToPoint(CGPointMake(73.297, 3.961), controlPoint1:CGPointMake(62.279, 17.812), controlPoint2:CGPointMake(35.93, 13.03))
        pathPath.addCurveToPoint(CGPointMake(113.518, 5.036), controlPoint1:CGPointMake(110.664, -5.108), controlPoint2:CGPointMake(102.33, 17.089))
        pathPath.addCurveToPoint(CGPointMake(142.677, 17.72), controlPoint1:CGPointMake(119.149, -1.029), controlPoint2:CGPointMake(132.805, 0.211))
        pathPath.addCurveToPoint(CGPointMake(150.684, 38.209), controlPoint1:CGPointMake(150.43, 31.471), controlPoint2:CGPointMake(149.889, -3.265))
        
        return pathPath;
    }
    
    func path2Path() -> UIBezierPath{
        let path2Path = UIBezierPath()
        path2Path.moveToPoint(CGPointMake(1.326, 34.987))
        path2Path.addCurveToPoint(CGPointMake(3.239, 2.692), controlPoint1:CGPointMake(-0.931, 22.052), controlPoint2:CGPointMake(-0.315, 4.062))
        path2Path.addCurveToPoint(CGPointMake(38.084, 2.692), controlPoint1:CGPointMake(6.793, 1.321), controlPoint2:CGPointMake(16.586, 12.701))
        path2Path.addCurveToPoint(CGPointMake(78.11, 5.414), controlPoint1:CGPointMake(59.581, -7.318), controlPoint2:CGPointMake(40.743, 14.483))
        path2Path.addCurveToPoint(CGPointMake(113.823, 2.692), controlPoint1:CGPointMake(115.476, -3.655), controlPoint2:CGPointMake(88.008, 9.924))
        path2Path.addCurveToPoint(CGPointMake(139.719, 5.414), controlPoint1:CGPointMake(121.792, 0.459), controlPoint2:CGPointMake(120.544, 11.445))
        path2Path.addCurveToPoint(CGPointMake(150.684, 35.568), controlPoint1:CGPointMake(148.404, 2.682), controlPoint2:CGPointMake(149.889, -5.906))
        
        return path2Path;
    }
    
    func path3Path() -> UIBezierPath{
        let path3Path = UIBezierPath()
        path3Path.moveToPoint(CGPointMake(1.326, 41.03))
        path3Path.addCurveToPoint(CGPointMake(3.239, 8.734), controlPoint1:CGPointMake(-0.931, 28.095), controlPoint2:CGPointMake(-0.315, 10.105))
        path3Path.addCurveToPoint(CGPointMake(39.599, 16.264), controlPoint1:CGPointMake(6.793, 7.364), controlPoint2:CGPointMake(18.102, 26.274))
        path3Path.addCurveToPoint(CGPointMake(82.193, 16.264), controlPoint1:CGPointMake(61.097, 6.255), controlPoint2:CGPointMake(44.826, 25.333))
        path3Path.addCurveToPoint(CGPointMake(121.831, 3.152), controlPoint1:CGPointMake(119.56, 7.195), controlPoint2:CGPointMake(96.016, 10.385))
        path3Path.addCurveToPoint(CGPointMake(141.943, 0.808), controlPoint1:CGPointMake(129.8, 0.919), controlPoint2:CGPointMake(122.768, 6.84))
        path3Path.addCurveToPoint(CGPointMake(150.684, 41.611), controlPoint1:CGPointMake(150.628, -1.923), controlPoint2:CGPointMake(149.889, 0.137))
        
        return path3Path;
    }
    
    func rectanglePath() -> UIBezierPath{
        let rectanglePath = UIBezierPath(rect:CGRectMake(0, 0, 150, 180))
        return rectanglePath;
    }

}
