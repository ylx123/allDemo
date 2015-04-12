//
//  UIColorExtension.swift
//
//  Created by go on 8/10/14.
//  Copyright (c) 2014 bitgather. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha255: CGFloat = 255.0)
    {
        self.init(red: red255 / 255.0, green: green255 / 255.0, blue: blue255 / 255.0, alpha: alpha255 / 255.0)
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1.0)
    {
        let red:CGFloat   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green:CGFloat = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue:CGFloat  = CGFloat((hex & 0x0000FF)) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hexa: UInt32)
    {
        let red:CGFloat   = CGFloat((hexa & 0xFF000000) >> 24) / 255.0
        let green:CGFloat = CGFloat((hexa & 0x00FF0000) >> 16) / 255.0
        let blue:CGFloat  = CGFloat((hexa & 0x0000FF00) >> 8) / 255.0
        let alpha:CGFloat = CGFloat((hexa & 0x000000FF)) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hex: String)
    {
        var red:CGFloat   = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat  = 0.0
        var alpha:CGFloat = 1.0
        
        let scanner = NSScanner(string: hex)
        var hexValue: UInt32 = 0
        if scanner.scanHexInt(&hexValue) {
            if count(hex) == 8 {
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat((hexValue & 0x000000FF)) / 255.0
            } else if count(hex) == 6 {
                red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF)) / 255.0
            }
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func hexValue()->String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var aplha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &aplha)
        
        
        var redDec = Int(red * 255)
        var greenDec = Int(green * 255)
        var blueDec = Int(blue * 255)
        var returnString = NSString(format: "%02x%02x%02x", redDec, greenDec, blueDec)
       
        return returnString as String
    
    }
    
    func getRedValue()->CGFloat{
    
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var aplha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &aplha)
        

        
        return red*255
        
    }

    func getBlueValue()->CGFloat{
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var aplha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &aplha)
        

        
        return blue*255
        
    }

    func getGreenValue()->CGFloat{
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var aplha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &aplha)
        

        
        return green*255
        
    }

    func getAplha()->CGFloat{
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var aplha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &aplha)
        

        return aplha
        
    }

    
    class func color255(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 255.0) -> UIColor!
    {
        return UIColor(red255: red, green255: green, blue255: blue, alpha255: alpha)
    }

    class func colorHex(hex: UInt32, alpha: CGFloat = 1.0) -> UIColor!
    {
        return UIColor(hex: hex, alpha: alpha)
    }
    
    class func colorHexa(hexa: UInt32) -> UIColor!
    {
        return UIColor(hexa: hexa)
    }
    
    class func colorHex(hex: String) -> UIColor!
    {
        return UIColor(hex: hex)
    }
    
    class func random() -> UIColor!
    {
        let red:CGFloat   = CGFloat(arc4random() % UInt32(255));
        let green:CGFloat = CGFloat(arc4random() % UInt32(255));
        let blue:CGFloat  = CGFloat(arc4random() % UInt32(255));
        return UIColor.color255(red, green: green, blue: blue, alpha: 255.0)
    }
    
    class func randoma() -> UIColor!
    {
        let red:CGFloat   = CGFloat(arc4random() % UInt32(255));
        let green:CGFloat = CGFloat(arc4random() % UInt32(255));
        let blue:CGFloat  = CGFloat(arc4random() % UInt32(255));
        let alpha:CGFloat = CGFloat(arc4random() % UInt32(255));
        return UIColor.color255(red, green: green, blue: blue, alpha: alpha)
    }
}