//
//  StickerViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class StickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var imgv = UIImageView(frame: CGRect(x: 0, y: 64, width: mw, height: mh - 100 - 64))
        imgv.image = UIImage(named: "img1.jpg")
        imgv.contentMode = UIViewContentMode.ScaleAspectFit
        imgv.backgroundColor = UIColor.redColor()
        self.view.addSubview(imgv)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
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
