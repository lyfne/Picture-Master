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
    var controlButtons = [ColorButton]()
    
    var layoutX: NSLayoutConstraint = NSLayoutConstraint()
    var layoutY: NSLayoutConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(layer)
        layer.zPosition = -100
        
        colorButton.setVC(self)
        colorButton.fillColor = UIColor(hue: 0.1, saturation: 0.8, brightness: 1.0, alpha: 0.8).CGColor
        colorButton.refresh()
        
        layoutX = NSLayoutConstraint(item: colorButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        layoutY = NSLayoutConstraint(item: colorButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([layoutX, layoutY])
        self.view.layoutSubviews()
        
        initColorButtons()
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
        for i in 2 ... 8 {
            let button: ColorButton = ColorButton()
            
            button.frame = colorButton.frame
            button.setVC(self)
            button.direction = ColorButton.MoveDirection.DirectionY
            
            let hue = Double(i) * 0.1
            button.fillColor = UIColor(hue: CGFloat(hue), saturation: 0.8, brightness: 1.0, alpha: 0.8).CGColor
            button.refresh()
            self.view.addSubview(button)
            controlButtons.append(button)
        }
        
        for i in 1...2 {
            let button: ColorButton = ColorButton()
            
            button.frame = colorButton.frame
            button.setVC(self)
            button.direction = ColorButton.MoveDirection.DirectionXY
            
            button.fillColor = colorButton.fillColor
            button.borderWidth = CGFloat(i) * 2
            button.refresh()
            self.view.addSubview(button)
            controlButtons.append(button)
        }
        
        self.view.bringSubviewToFront(colorButton)
    }
    
    func resizeView() {
        self.view.frame = (self.view.superview?.frame)!
        
        NSLayoutConstraint.deactivateConstraints([layoutX, layoutY])
        layoutX = NSLayoutConstraint(item: colorButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: BUTTON_VIEW_MARGIN + BUTTON_SIZE_INIT - self.view.frame.size.width / 2)
        layoutY = NSLayoutConstraint(item: colorButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: self.view.frame.size.height / 2 - BUTTON_VIEW_MARGIN - BUTTON_SIZE_INIT)
        NSLayoutConstraint.activateConstraints([layoutX, layoutY])
        self.view.layoutSubviews()
        
        colorButton.userInteractionEnabled = false
        
        var xIndex = 0
        var yIndex = 0
        var xyIndex = 0
        
        for btn in controlButtons {
            if !bIsOpen {
                btn.frame = colorButton.frame
            }
            
            UIView.animateWithDuration(0.2, animations: {
                if btn.direction == ColorButton.MoveDirection.DirectionX {
                    btn.frame.origin.x += (CGFloat(xIndex + 1) * (BUTTON_SIZE_INIT * 2 + BUTTON_MARGIN) +  BUTTON_MOVE_OFFSET) * (self.bIsOpen ? -1 : 1) + (self.bIsOpen ? 0 : BUTTON_MOVE_OFFSET)
                    xIndex += 1
                }else if btn.direction == ColorButton.MoveDirection.DirectionY {
                    btn.frame.origin.y += (CGFloat(yIndex + 1) * (BUTTON_SIZE_INIT * 2 + BUTTON_MARGIN) + BUTTON_MOVE_OFFSET) * (self.bIsOpen ? 1 : -1) - (self.bIsOpen ? 0 : BUTTON_MOVE_OFFSET)
                    yIndex += 1
                }else {
                    btn.frame.origin.x += (CGFloat(xyIndex + 1) * (BUTTON_SIZE_INIT * 2 + BUTTON_MARGIN) + BUTTON_MOVE_OFFSET) * (self.bIsOpen ? -1 : 1) + (self.bIsOpen ? 0 : BUTTON_MOVE_OFFSET)
                    btn.frame.origin.y += (CGFloat(xyIndex + 1) * (BUTTON_SIZE_INIT * 2 + BUTTON_MARGIN) + BUTTON_MOVE_OFFSET) * (self.bIsOpen ? 1 : -1) - (self.bIsOpen ? 0 : BUTTON_MOVE_OFFSET)
                    xyIndex += 1
                }
                btn.alpha = self.bIsOpen ? 0 : 1
                self.view.backgroundColor = self.bIsOpen ? UIColor(red: 0, green: 0, blue: 0, alpha: 0) : UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            }, completion: { (finished: Bool) -> Void in
                //  bIsOpen is changed!!
                UIView.animateWithDuration(0.1, animations: {
                    if btn.direction == ColorButton.MoveDirection.DirectionX {
                        btn.frame.origin.x += (self.bIsOpen ? -BUTTON_MOVE_OFFSET : 0)
                    }else if btn.direction == ColorButton.MoveDirection.DirectionY {
                        btn.frame.origin.y += (self.bIsOpen ? BUTTON_MOVE_OFFSET : 0)
                    }else {
                        btn.frame.origin.x += (self.bIsOpen ? -BUTTON_MOVE_OFFSET : 0)
                        btn.frame.origin.y += (self.bIsOpen ? BUTTON_MOVE_OFFSET : 0)
                    }
                }, completion: { (finished: Bool) -> Void in
                    if !self.bIsOpen {
                        self.view.frame = CGRectMake(BUTTON_VIEW_MARGIN, (self.view.superview?.frame.size.height)! - BUTTON_VIEW_MARGIN - BUTTON_SIZE_INIT * 2, BUTTON_SIZE_INIT * 2, BUTTON_SIZE_INIT * 2)
                        
                        NSLayoutConstraint.deactivateConstraints([self.layoutX, self.layoutY])
                        self.layoutX = NSLayoutConstraint(item: self.colorButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
                        self.layoutY = NSLayoutConstraint(item: self.colorButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
                        
                        NSLayoutConstraint.activateConstraints([self.layoutX, self.layoutY])
                        self.view.layoutSubviews()
                    }
                    
                    self.colorButton.userInteractionEnabled = true
                })
            })
        }
    }
    
    func selectColor(btn: ColorButton) {
        if btn.direction == ColorButton.MoveDirection.DirectionY {
            let fillColor = colorButton.fillColor
            colorButton.fillColor = btn.fillColor
            colorButton.refresh()
            
            for button in controlButtons{
                if button.direction != ColorButton.MoveDirection.DirectionY {
                    button.fillColor = btn.fillColor
                    button.refresh()
                }
            }
            
            btn.fillColor = fillColor
            btn.refresh()
        }else if btn.direction == ColorButton.MoveDirection.DirectionXY {
            let borderWidth = colorButton.borderWidth
            colorButton.borderWidth = btn.borderWidth
            colorButton.refresh()
            
            for button in controlButtons{
                if button.direction != ColorButton.MoveDirection.DirectionXY {
                    button.borderWidth = btn.borderWidth
                    button.refresh()
                }
            }
            
            btn.borderWidth = borderWidth
            btn.refresh()
        }
        
        bIsOpen = !bIsOpen
    }
}
