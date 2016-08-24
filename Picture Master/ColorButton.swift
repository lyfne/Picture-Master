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

    enum MoveDirection {
        case DirectionX
        case DirectionY
        case DirectionXY
    }
    
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    var fillColor: CGColor = UIColor.redColor().CGColor
    var strokeColor: CGColor = UIColor.whiteColor().CGColor
    var borderWidth: CGFloat = 0
    var buttonSize: CGFloat = BUTTON_SIZE_INIT
    var bIsSelected: Bool = false
    var direction: MoveDirection = .DirectionX

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
        
        let startShape = UIBezierPath(arcCenter: CGPoint(x: buttonSize, y: buttonSize), radius: buttonSize - BUTTON_SIZE_CHANGE_VALUE - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        let endShape = UIBezierPath(arcCenter: CGPoint(x: buttonSize, y: buttonSize), radius: buttonSize - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startShape.CGPath
        animation.toValue = endShape.CGPath
        animation.duration = 0.1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        shapeLayer.addAnimation(animation, forKey: animation.keyPath)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        self.toolBarVC.resizeView()
        self.toolBarVC.view.layoutSubviews()
        self.toolBarVC.selectColor(self)
       
        let startShape = UIBezierPath(arcCenter: CGPoint(x: buttonSize, y: buttonSize), radius: buttonSize - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        let endShape = UIBezierPath(arcCenter: CGPoint(x: buttonSize, y: buttonSize), radius: buttonSize - BUTTON_SIZE_CHANGE_VALUE - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startShape.CGPath
        animation.toValue = endShape.CGPath
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        shapeLayer.addAnimation(animation, forKey: animation.keyPath)
    }
    
    //MARK: - Private Function
    
    func refresh() {
         let startShape = UIBezierPath(arcCenter: CGPoint(x: buttonSize, y: buttonSize), radius: buttonSize - BUTTON_SIZE_CHANGE_VALUE - 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = startShape.CGPath
    }
    
    func setup() {
        shapeLayer = self.layer as! CAShapeLayer
        
        refresh()
    }
}
