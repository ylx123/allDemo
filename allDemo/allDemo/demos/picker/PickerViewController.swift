//
//  PickerViewDemo.swift
//  allDemo
//
//  Created by nahaowan on 15/4/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        createInterface()
        // Do any additional setup after loading the view.
    }
    
    func createInterface(){
        self.view.backgroundColor = UIColor.whiteColor()
        var label = UILabel(frame: CGRect(x: 10, y: 100, width: 60, height: 30))
        label.text = "性别："
        self.view.addSubview(label)
        
        var button = UIButton(frame: CGRect(x: 80, y: 100, width: 60, height: 30))
        button.setTitle("选择", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "openSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
    }
    func openSelector(button:UIButton){
        var picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: UIScreen.mainScreen().bounds.width, height: 100))
        picker.dataSource = self
        picker.delegate = self
        picker.layer.masksToBounds = true
        picker.layer.borderColor = UIColor.redColor().CGColor
        
        picker.layer.borderWidth = 1
        
        self.view.addSubview(picker)
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println(row)
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.text = row == 0 ? "男" : "女"
        return label
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
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
