//
//  EventViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/24.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        var v1 = UIView(frame: CGRect(x: 0, y: 64, width: mw, height: mh - 64))
        self.view.addSubview(v1)
        
        var b1 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        b1.setTitle("b1", forState: UIControlState.Normal)
        b1.addTarget(self, action: "taped:", forControlEvents: UIControlEvents.TouchUpInside)
        b1.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        v1.addSubview(b1)
        
        var v = SubView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        v.b2.addTarget(self, action: "taped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(v)
        
        // Do any additional setup after loading the view.
    }
    func taped(button:UIButton){
        println(button.titleLabel?.text)
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
