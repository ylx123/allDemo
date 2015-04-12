//
//  selectBar.swift
//  allDemo
//
//  Created by nahaowan on 15/4/10.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

//选中回调
@objc protocol HWSelectBarDelegate : NSObjectProtocol {
    func didSelectedIndex(#index:Int)
}

class selectBar: UIView {
    

    var currentIndex = 0
    var delegate:HWSelectBarDelegate?
    var buttons:NSMutableArray?
    var titles:Array<String>? {
        didSet {
            reloadButtons()
        }
    }
    var normalColor = UIColor.blackColor()
    var selectedColor:UIColor = UIColor.whiteColor(){
        didSet {
            var button = buttons?.objectAtIndex(currentIndex) as! UIButton
            button.setTitleColor(selectedColor, forState: UIControlState.Normal)
        }
    }
    
    var line:UILabel!
    
    var sizes:Array<CGSize>?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        line = UILabel()
        line.frame = CGRect(x: 0, y: 42, width: 50, height: 2)
        line.backgroundColor = UIColor.greenColor()
        self.addSubview(line)
    }
    
    func reloadButtons(){
        for view in self.subviews{
            if(view.isKindOfClass(UIButton.self)){
                view.removeFromSuperview()
            }
        }
        
        buttons?.removeAllObjects()
        if(titles?.count > 0){
            var leftx:CGFloat = UIScreen.mainScreen().bounds.width
            leftx -= CGFloat(titles!.count) * 60.0
            leftx -= CGFloat(titles!.count - 1) * 15.0
            leftx /= 2
            var tmpbuttons:NSMutableArray = NSMutableArray()
            var beforButton:UIButton?
            for (i,title) in enumerate( titles! ){
                
                
                if(beforButton != nil){
                    leftx = beforButton!.frame.maxX + 15
                }
                

                var button = UIButton(frame: CGRect(x: leftx, y: 0, width: 60, height: 43))
                button.setTitle(title, forState: UIControlState.Normal)
                button.addTarget(self, action: "tapedButton:", forControlEvents: UIControlEvents.TouchUpInside)
                button.titleLabel?.textAlignment = NSTextAlignment.Center
                beforButton = button
                self.addSubview(button)
                tmpbuttons.addObject(button)
                
            }
            self.buttons = tmpbuttons
            changeToIndex(index: currentIndex)
            
        }
    }
    
    func tapedButton(button:UIButton){
        var index = buttons?.indexOfObject(button)
        if(delegate != nil){
            delegate?.didSelectedIndex(index: index!)
            
        }
        changeToIndex(index: index!)
    }
    func changeToIndex(#index:Int){
        currentIndex = index
        
        for (i,button) in enumerate( buttons!) {
            button.setTitleColor(normalColor, forState: UIControlState.Normal)
            
            if(currentIndex == i){
                if(line.frame.minX == 0 && i == 0){
                    line.frame.origin.x = button.frame.minX
                    
                }
                button.setTitleColor(selectedColor, forState: UIControlState.Normal)
                
            }
        }
        
        var button = buttons?.objectAtIndex(index) as! UIButton
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.line.frame.origin.x = button.frame.origin.x
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }


}
