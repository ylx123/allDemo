//
//  graphViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/4/10.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class graphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var scale:CGFloat = 1.0
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var view = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        view.backgroundColor = UIColor.redColor()
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.redColor().CGColor
        view.layer.borderWidth = 1
        
        var view2 = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        view2.backgroundColor = UIColor.greenColor()
        view2.layer.masksToBounds = true
        view2.layer.borderColor = UIColor.redColor().CGColor
        view2.layer.borderWidth = 1
        self.view.addSubview(view2)
        
        
        var degrees = 75.0
        var radius = degrees * M_PI / 180.0
        var xfrm = CGAffineTransformMakeRotation(CGFloat(radius))
        var rect = CGRectApplyAffineTransform (view.bounds, xfrm)

        
        var tsize = CGSizeMake(rect.size.width * scale, rect.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(tsize, false, 0.0)
        var context = UIGraphicsGetCurrentContext()
        
        CGContextScaleCTM(context, scale , scale)
        CGContextTranslateCTM( context, rect.width/2,  rect.height/2) ;
        CGContextRotateCTM(context, CGFloat(radius));
        CGContextTranslateCTM( context, -view.frame.size.width/2 , -view.frame.size.height/2 ) ;
        
        
        //      self.view.addSubview(view)
        view.layer.renderInContext(context)
//        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        
        println(view.frame)
        println(rect)
        println(image.size)
        
        var imgv = UIImageView(frame:CGRect(x: rect.origin.x,y: rect.origin.y, width: tsize.width, height: tsize.height))
        imgv.center = view.center
        println(imgv.frame)
        imgv.contentMode = UIViewContentMode.Center
        imgv.layer.masksToBounds = true
        imgv.layer.borderWidth = 1
        imgv.layer.borderColor = UIColor.redColor().CGColor
        imgv.image = image
        imgv.alpha = 0.3
        self.view.addSubview(imgv)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
