//
//  collectionViewWithHeaderViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class collectionViewWithHeaderViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var collev:UICollectionView!
    var close = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        var clayout = UICollectionViewFlowLayout()
        clayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        clayout.headerReferenceSize = CGSize(width: mw, height: 30)
        
        collev = UICollectionView(frame: CGRect(x: 0, y: 0, width: mw, height: mh ),collectionViewLayout:clayout)
        collev.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collev.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collev.backgroundColor = UIColor.clearColor()
        collev.dataSource = self
        collev.delegate = self
        
        self.view.addSubview(collev)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.yellowColor()
            
        }else{
            cell.backgroundColor = UIColor.greenColor()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as UICollectionReusableView
        if(kind == UICollectionElementKindSectionHeader){
            view.backgroundColor = UIColor.blueColor()
            var title = UILabel(frame: view.frame)
            title.text = "header"
            title.textColor = UIColor.whiteColor()
            title.textAlignment = NSTextAlignment.Center
            view.addSubview(title)
            var close = UIButton(frame:CGRect(x: 0,y: 0,width: 70,height: view.frame.height))
            close.setTitle("关闭", forState: UIControlState.Normal)
            close.addTarget(self, action: "closeSection", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(close)
            
        }
        return view
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var random = CGFloat(arc4random_uniform((UInt32(200))))
        
        
        if(self.close && indexPath.section == 0){
            return CGSizeMake(100, 0)
        }else{
            return CGSizeMake(100, 100)
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if(self.close && section == 0){
            return 0
        }else{
            return 3
        }
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        if(self.close && section == 0){
            return 0
        }else{
            return 3
        }

    }
    
    func closeSection(){
        
        
        collev.reloadData()
        self.collev.collectionViewLayout.invalidateLayout()
//        var clayout = UICollectionViewFlowLayout()
//        clayout.scrollDirection = UICollectionViewScrollDirection.Vertical
//        clayout.headerReferenceSize = CGSize(width: mw, height: 30)
//        collev.setCollectionViewLayout(clayout, animated: true) { (finish:Bool) -> Void in
//            self.close = self.close ? false : true
//        }

        
        
       collev.performBatchUpdates({ () -> Void in
//            self.collev.collectionViewLayout.invalidateLayout()
//            
//            var clayout = UICollectionViewFlowLayout()
//            clayout.scrollDirection = UICollectionViewScrollDirection.Vertical
//            clayout.minimumLineSpacing = 0
//            clayout.minimumInteritemSpacing = 0
//
//            
//            if(self.close){
//                clayout.itemSize = CGSize(width: 0, height: 0)
//
//            }else{
//                clayout.itemSize = CGSize(width: 100, height: 100)
//            }
//
//            clayout.headerReferenceSize = CGSize(width: mw, height: 30)
//            self.collev.setCollectionViewLayout(clayout, animated: true)
//            
            }, completion: { (finish:Bool) -> Void in
              self.close = self.close ? false : true
      })
        

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
