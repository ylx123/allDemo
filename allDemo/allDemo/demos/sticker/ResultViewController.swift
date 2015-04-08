//
//  ResultViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var img:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        var imgv = UIImageView(frame: CGRect(x: 0, y: 64, width: mw, height: mh - 64 - 100))
        imgv.image = img
        imgv.contentMode = UIViewContentMode.ScaleAspectFit
        imgv.backgroundColor = UIColor.redColor()
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
