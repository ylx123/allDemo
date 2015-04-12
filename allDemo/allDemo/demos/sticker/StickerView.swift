//
//  StickerView.swift
//  allDemo
//
//  Created by nahaowan on 15/3/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class StickerView: ZDStickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(sticker:Sticker) {
        
        var x:Int = Int(arc4random_uniform(200))
        var y:Int = Int(arc4random_uniform(200))
        super.init(frame: CGRect(x: x, y: y, width: 100, height: 100))
        var imgv = UIImageView(frame: self.bounds)
        imgv.image = sticker.image
        self.contentView = imgv
        
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
