//
//  CircleView.swift
//  allDemo
//
//  Created by nahaowan on 15/3/18.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

protocol CircleViewAnimationDelegate {
    func circleViewAnimationDidFinish(it:Int)
}

class CircleView: UIView {
    var circleLayer:CAShapeLayer!
    var nowValue = 1.0
    var step = 0.0667
    var animation : CABasicAnimation!
    var timeLabel:UILabel!
    var finishDelegate:CircleViewAnimationDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       

        var frame = frame
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor.redColor().CGColor
        circleLayer.lineWidth = 5.0;
        

        circleLayer.strokeEnd = 0.0

        self.layer.addSublayer(circleLayer)


    }
    
    func animateCircle(time: Int) {
        
        animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.completionBlock = {(finish:Bool) in
            self.finishDelegate.circleViewAnimationDidFinish(time)
        }

        animation.duration = 1

        animation.fromValue = (1.0-1/15*Float(time-1))
        animation.toValue = (1.0-1/15*Float(time))
        
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        

        circleLayer.strokeEnd = CGFloat(animation.toValue as NSNumber)
        
        
        circleLayer.addAnimation(animation, forKey: "animateCircle")
        
        
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
