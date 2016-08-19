//
//  ColorButton.swift
//  Picture Master
//
//  Created by Fan's Mac on 16/8/6.
//  Copyright © 2016年 Lifestyle Studio. All rights reserved.
//

import UIKit
import QuartzCore

class ColorButton: ResizeButton {

    var shapeLayer: CAShapeLayer = CAShapeLayer()
    var shapePath: UIBezierPath = UIBezierPath()
    var fillColor: CGColor = UIColor.redColor().CGColor
    var strokeColor: CGColor = UIColor.whiteColor().CGColor
    var borderWidth: CGFloat = 2
    var bIsSelected: Bool = false

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let endShape = UIBezierPath(arcCenter: CGPoint(x: buttonSizeInit + buttonSizeOffset, y: buttonSizeInit + buttonSizeOffset), radius: buttonSizeInit + buttonSizeOffset - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        shapePath.applyTransform(CGAffineTransformMakeTranslation(buttonSizeOffset, buttonSizeOffset))
        shapeLayer.path = shapePath.CGPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = shapePath.CGPath
        animation.toValue = endShape.CGPath
        animation.duration = 0.1 // duration is 1 sec
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        shapeLayer.addAnimation(animation, forKey: animation.keyPath)
        shapePath = endShape
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        let endShape = UIBezierPath(arcCenter: CGPoint(x: buttonSizeInit, y: buttonSizeInit), radius: buttonSizeInit - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        shapePath.applyTransform(CGAffineTransformMakeTranslation(-buttonSizeOffset, -buttonSizeOffset))
        shapeLayer.path = shapePath.CGPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self
        animation.fromValue = shapePath.CGPath
        animation.toValue = endShape.CGPath
        animation.duration = 0.2 // duration is 1 sec
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        shapeLayer.addAnimation(animation, forKey: animation.keyPath)
        shapePath = endShape
    }
    
    //MARK: - Private Function
    
    func refresh() {
        self.performSelectorOnMainThread(#selector(setNeedsDisplay), withObject: nil, waitUntilDone: false)
    }
    
    func setup() {
        shapeLayer = self.layer as! CAShapeLayer
        
        shapePath.addArcWithCenter(CGPoint(x: buttonSizeInit, y: buttonSizeInit), radius: buttonSizeInit - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = shapePath.CGPath
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.toolBarVC.resizeView()
        self.toolBarVC.view.layoutSubviews()
        self.toolBarVC.selectColor()
    }

}
