//
//  TimerEx.swift
//  allDemo
//
//  Created by nahaowan on 15/3/18.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

extension NSTimer {
    class NSTimerCallbackHolder : NSObject {
        var callback: () -> ()
        
        init(callback: () -> ()) {
            self.callback = callback
        }
        
        func tick(timer: NSTimer) {
            callback()
        }
    }
    
    class func scheduledTimerWithTimeInterval(ti: NSTimeInterval, repeats yesOrNo: Bool, closure: () -> ()) -> NSTimer! {
        var holder = NSTimerCallbackHolder(closure)
        holder.callback = closure
        
        return NSTimer.scheduledTimerWithTimeInterval(ti, target: holder, selector: Selector("tick:"), userInfo: nil, repeats: yesOrNo)
    }
}
