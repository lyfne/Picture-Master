//
//  ResizeButton.swift
//  Picture Master
//
//  Created by Fan's Mac on 16/8/6.
//  Copyright © 2016年 Lifestyle Studio. All rights reserved.
//

import UIKit
import QuartzCore

class ResizeButton: UIButton {

    let buttonSizeOffset: CGFloat = 3
    var buttonSizeInit: CGFloat = 21
    
    var toolBarVC: ToolBarViewController = ToolBarViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShadow()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userInteractionEnabled = false
        
        let center: CGPoint = self.center
        self.frame.size = CGSizeMake(self.frame.width + buttonSizeOffset * 2, self.frame.height + buttonSizeOffset * 2)
        self.center = center
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let center: CGPoint = self.center
        self.frame.size = CGSizeMake(self.frame.width - buttonSizeOffset * 2, self.frame.height - buttonSizeOffset * 2)
        self.center = center
    }
    
    func setupShadow() {
        self.layer.shadowOffset = CGSizeMake(0, 1)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 0.5
    }
    
    func setVC(vc: ToolBarViewController) {
        toolBarVC = vc
    }
}
