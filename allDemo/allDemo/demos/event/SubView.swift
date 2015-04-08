//
//  SubView.swift
//  allDemo
//
//  Created by nahaowan on 15/3/24.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class SubView: UIView {
    
    var b2:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        b2 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        b2.backgroundColor = UIColor.redColor()
        b2.setTitle("b2", forState: UIControlState.Normal)
        b2.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        b2.addTarget(self.superview, action: "taped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b2)
        
        
    }
    
    func taped(button:UIButton){

        println("sub\( button.titleLabel?.text)")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
