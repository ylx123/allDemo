//
//  RotateViewController.swift
//  allDemo
//
//  Created by 郑高照 on 15/4/25.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class RotateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        var view2 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view2.backgroundColor = UIColor.blueColor()

        
        var view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.greenColor()
        view.alpha = 0.5
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "abc"
        view.addSubview(label)
        
        
        var degree:CGFloat = 165
        var angle:CGFloat = CGFloat(M_PI) * degree / 180
        var transform = CGAffineTransformMakeRotation(angle)
        view.transform = transform
        
        var view3 = UIView(frame: view.frame)
        view3.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(view3)
        self.view.addSubview(view2)
        self.view.addSubview(view)
        println(view.frame)
        println(view2.frame)
        println(view3.frame)
        
        var img1 = imageWithView(view)

        var imgv1 = UIImageView()
        imgv1.image = img1
        imgv1.frame.origin = CGPoint(x: 150, y: 250)
        imgv1.frame.size = img1.size
        self.view.addSubview(imgv1)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageWithView(view:UIView)->UIImage{
        

        
        var radius = atan2f(Float(view.transform.b), Float(view.transform.a))

        var tmprect = boundingRectAfterRotatingRect(view.frame, radians:0)
        
        UIGraphicsBeginImageContextWithOptions(tmprect.size, false, 0.0);

        
        var context = UIGraphicsGetCurrentContext();
        
        var xv = UIView(frame: tmprect)
        xv.backgroundColor = UIColor.random()
        xv.layer.renderInContext(context)
        CGContextScaleCTM(context, 1.0, 1.0)
        CGContextTranslateCTM( context, 0.5 * tmprect.size.width , 0.5 * tmprect.size.height)
        CGContextRotateCTM(context, CGFloat(radius))
        CGContextTranslateCTM( context, -0.5 * view.bounds.width, -0.5 * view.bounds.height)
        println(view.frame)
        println(view.bounds)
        //view.drawViewHierarchyInRect(CGRect(origin: CGPointZero, size: view.frame.size), afterScreenUpdates: true)
        //[view.layer renderInContext:UIGraphicsGetCurrentContext()];
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    
    }

    func boundingRectAfterRotatingRect(rect:CGRect, radians:CGFloat) -> CGRect {
    
        var tmp = UIView(frame: rect)
    
        var xfrm = CGAffineTransformMakeRotation(radians)
        tmp.transform = xfrm
        return tmp.frame;
    
    }
    


    
}
