//
//  Conformer.swift
//  allDemo
//
//  Created by nahaowan on 15/3/18.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

protocol MyProtocol2{
    var k:Int {get set}
}
class Conformer: NSObject,MyProtocol2 {
    var k:Int
    init(v:Int){
        self.k = v
    }
}
