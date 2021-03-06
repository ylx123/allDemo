//
//  ViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

let mw = UIScreen.mainScreen().bounds.width
let mh = UIScreen.mainScreen().bounds.height

class RootController: UITableViewController,UITableViewDataSource,UITableViewDelegate {

    var items:[String] = []
    var controllers:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "allDemo"
        
 
        var xfloat:CGFloat = CGFloat(1.0)
        println(Int(xfloat))
        
        
        items.append("collectionViewWithHeader")
        items.append("标签")
        items.append("录音")
        items.append("贴纸")
        items.append("事件")
        items.append("画图")
        items.append("选择器")
        items.append("qq登录")
        items.append("选择器")
        items.append("旋转")
        controllers.append(collectionViewWithHeaderViewController())
        controllers.append(TagController())
        controllers.append(RecorderViewController())
        controllers.append(StickerViewController())
        controllers.append(EventViewController())
        controllers.append(graphViewController())
        controllers.append(SelectTestViewController())
        controllers.append(QQLoginViewController())
        controllers.append(PickerViewController())
        controllers.append(RotateViewController())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var item = items[indexPath.row]
        var controller = controllers[indexPath.row]
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = item
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var controller = controllers[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

