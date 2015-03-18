//
//  TagController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class TagController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var imgv = UIImageView(image: UIImage(named: "img1.jpg"))
        
        imgv.frame = CGRect(x: 0, y: 100, width: mw, height: mw * imgv.frame.height / imgv.frame.width)
        self.view.addSubview(imgv)
        
        var tap = UITapGestureRecognizer(target: self, action: "tapedImg:")
        imgv.userInteractionEnabled = true
        imgv.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func tapedImg(tap:UITapGestureRecognizer){
    
        var label = UILabel()
        label.frame.size = CGSize(width: 20, height: 20)
        label.center = tap.locationInView(tap.view)

        label.backgroundColor = UIColor.blackColor()
        tap.view?.addSubview(label)
        
        var move = UIPanGestureRecognizer(target: self, action: "moveLabel:")
        label.userInteractionEnabled = true
        label.addGestureRecognizer(move)
    }
    
    func moveLabel(move:UIPanGestureRecognizer){
    
        var view = move.view!.superview!
        var xy = move.locationInView(view)
        
        move.view!.center.x = xy.x
        move.view!.center.y = xy.y
        
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
