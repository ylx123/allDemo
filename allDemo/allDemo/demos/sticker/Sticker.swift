//
//  Sticker.swift
//  allDemo
//
//  Created by nahaowan on 15/3/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class Sticker: NSObject {
    var stickerID:Int!
    var image:UIImage!
    override init() {
        super.init()
    }
    init(image:UIImage,id:Int) {
        self.image = image
        self.stickerID = id
    }
}
