//
//  collectionViewWithHeaderViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class collectionViewWithHeaderViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var collev:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        var clayout = UICollectionViewFlowLayout()
        clayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        clayout.itemSize = CGSize(width: 100, height: 100)
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
        return 1
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
        }
        return view
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
