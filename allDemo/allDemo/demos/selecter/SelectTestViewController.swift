//
//  SelectTestViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/4/10.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class SelectTestViewController: UIViewController,HWSelectBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        var selector = selectBar(frame: CGRect(x: 0, y: 100, width: UIScreen.mainScreen().bounds.width, height: 44))
        selector.delegate = self
        selector.titles = ["按1","按2","按3","按4"]
        selector.selectedColor = UIColor.greenColor()
        selector.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(selector)
        

    }

    func didSelectedIndex(#index: Int) {
        println("taped index:\(index)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
