//
//  ToolBarViewController.swift
//  Picture Master
//
//  Created by Fan's Mac on 16/8/6.
//  Copyright © 2016年 Lifestyle Studio. All rights reserved.
//

import UIKit

class ToolBarViewController: UIViewController {

    @IBOutlet weak var colorButton: ColorButton!

    let layer: CAShapeLayer = CAShapeLayer()
    var bIsOpen: Bool = false
    var allConstraints = [NSLayoutConstraint]()
    var buttons = [ColorButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(layer)
        layer.zPosition = -100
        
        colorButton.setVC(self)
        colorButton.fillColor = UIColor(hue: 0.2, saturation: 0.8, brightness: 1.0, alpha: 0.8).CGColor
        colorButton.refresh()
        buttons.append(colorButton)
    }
    
    override func viewDidLayoutSubviews() {
       // initColorButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // MARK: - Public Function
    
    func setViewSize(size: CGSize) {
        self.view.frame.size = size
    }
    
    // MARK: - Action

    func initColorButtons() {
        for i in 2 ... 5 {
            let button: ColorButton = ColorButton()
            button.frame = colorButton.frame
            
            let hue = Double(i) * 0.2
            button.fillColor = UIColor(hue: CGFloat(hue), saturation: 0.8, brightness: 1.0, alpha: 0.8).CGColor
            self.view.addSubview(button)
            buttons.append(button)
        }
    }
    
    func resizeView() {
        self.view.frame = (self.view.superview?.frame)!
        NSLayoutConstraint.deactivateConstraints(allConstraints)
        allConstraints.removeAll()
        let xx = 35 - self.view.frame.size.width / 2
        let yy = self.view.frame.size.height / 2 - 45.5
        let layout = NSLayoutConstraint(item: colorButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: xx)
        allConstraints.append(layout)
        let layout2 = NSLayoutConstraint(item: colorButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: yy)
        allConstraints.append(layout2)
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    
    func selectColor() {
        addFadeAnimation(!bIsOpen)
        bIsOpen = !bIsOpen
    }
    
    func addFadeAnimation(bFadeIn: Bool) {
        let fShape = UIBezierPath(arcCenter: colorButton.center, radius: 1, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        let sShape = UIBezierPath(arcCenter: colorButton.center, radius: 1000, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self
        animation.fromValue = bFadeIn ? fShape.CGPath : sShape.CGPath
        animation.toValue = bFadeIn ? sShape.CGPath : fShape.CGPath
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        
        let animationColor = CABasicAnimation(keyPath: "fillColor")
        animationColor.fromValue = UIColor(red: 0, green: 0, blue: 0, alpha: bFadeIn ? 0.0 : 0.3).CGColor
        animationColor.toValue = UIColor(red: 0, green: 0, blue: 0, alpha: bFadeIn ? 0.3 : 0.0).CGColor
        animationColor.duration = 0.3
        animationColor.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animationColor.fillMode = kCAFillModeBoth
        animationColor.removedOnCompletion = false
        
        layer.addAnimation(animation, forKey: animation.keyPath)
        layer.addAnimation(animationColor, forKey: animationColor.keyPath)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if !bIsOpen {
            self.view.frame = CGRectMake(20, (self.view.superview?.frame.size.height)! - 62, 42, 42)
            NSLayoutConstraint.deactivateConstraints(allConstraints)
            allConstraints.removeAll()
            let layout = NSLayoutConstraint(item: colorButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: -6)
            allConstraints.append(layout)
            let layout2 = NSLayoutConstraint(item: colorButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: -4.5)
            allConstraints.append(layout2)
            NSLayoutConstraint.activateConstraints(allConstraints)
        }
        
        colorButton.userInteractionEnabled = true
    }
}
