//
//  QQLoginViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/4/15.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class QQLoginViewController: UIViewController,TencentSessionDelegate {

    var oQth:TencentOAuth!
    override func viewDidLoad() {
        super.viewDidLoad()

        createInterface()
        self.view.backgroundColor = UIColor.whiteColor()
        oQth = TencentOAuth(appId: "222222", andDelegate: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createInterface(){
        
        var loginButton = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 20))
        loginButton.setTitle("qq登录", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "loginQQ", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
        
    }
    func loginQQ(){
        
        var _permission = [kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO]
        oQth.authorize(_permission)
    }
    func tencentDidLogout() {
        println("logout")
    }

    func tencentDidLogin(){
        println("login")
    }
    
    func tencentDidNotLogin(cancel:Bool){
        println("not login")
    }
    func tencentDidNotNetWork() {
        println("no net")
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
