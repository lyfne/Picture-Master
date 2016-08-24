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
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

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
