//
//  StickerViewController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/20.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit

class StickerViewController: UIViewController,ZDStickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    var items = ["http://img.hb.aicdn.com/00cd5cd26ffcf3a604e7599f99774ca9944c00fc3f8c-AxPO4J_fw658",
                "http://img2.cheshi-img.com/product/1_720/p/27600/27617/539e884bbec36.jpg",
                "http://i4.3conline.com/images/piclib/201111/29/batch/1/118990/13225431144073j7j79rtmp_medium.jpg",
                "http://img2.xgo-img.com.cn/product/12_800x600/353/ceXpWDr9c5b0Y.jpg",
                "http://img2.xgo-img.com.cn/product/33_800x600/691/cekOgvanOwWE.jpg",
                "http://www.sinaimg.cn/dy/slidenews/4_img/2015_12/704_1579390_357773.jpg",
                ]
    var collev:UICollectionView!
    var mimgv:UIImageView!
    var stickerViewArray:[StickerView] = []
    var workview:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "img1.jpg")
        var theight = mw * image!.size.height/image!.size.width
        
        workview = UIView(frame: CGRect(x: 0, y: 64, width: mw, height: theight))
        workview.backgroundColor = UIColor.blackColor()
        workview.clipsToBounds = true
        self.view.addSubview(workview)
        
        mimgv = UIImageView(frame: CGRect(x: 0, y: 0, width: mw, height: theight))
        mimgv.image = image
        mimgv.contentMode = UIViewContentMode.ScaleAspectFit
        mimgv.backgroundColor = UIColor.blackColor()
        workview.addSubview(mimgv)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var clayout = UICollectionViewFlowLayout()
        clayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        clayout.itemSize = CGSize(width: 80, height: 80)
        clayout.minimumInteritemSpacing = 3
        clayout.minimumLineSpacing = 3
        
        
        collev = UICollectionView(frame: CGRect(x: 0, y:mh - 100 , width: mw, height: 100), collectionViewLayout: clayout)
        collev.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collev.backgroundColor = UIColor.clearColor()
        collev.dataSource = self
        collev.delegate = self
        
        self.view.addSubview(collev)
        
        var nextButton = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Bordered, target: self, action: "saveImage")
        self.navigationItem.rightBarButtonItem = nextButton
        // Do any additional setup after loading the view.
    }

    func stickerViewDidBeginEditing(sticker: ZDStickerView!) {
        //sticker.hideEditingHandles()
    }

    func stickerViewDidCancelEditing(sticker: ZDStickerView!) {
        
    }
    func stickerViewDidClose(sticker: ZDStickerView!) {
        
    }
    func stickerViewDidCustomButtonTap(sticker: ZDStickerView!) {
        
    }
    func stickerViewDidEndEditing(sticker: ZDStickerView!) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        for i in cell.subviews {
            i.removeFromSuperview()
        }
        
        
        var imgv = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        var item = items[indexPath.row]
        imgv.sd_setImageWithURL(NSURL(string: item)!)
        imgv.contentMode = UIViewContentMode.ScaleAspectFit
        cell.addSubview(imgv)
        imgv.tag = 1
        cell.backgroundColor  = UIColor.redColor()
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func addSticker(sticker:Sticker){
        var newStickerView = StickerView(sticker: sticker)
        newStickerView.delegate = self
        self.stickerViewArray.append(newStickerView)
        //[self.stickerViewArray addObject:newStickerView];
        workview.addSubview(newStickerView)

    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        var imgv = cell!.viewWithTag(1) as UIImageView
        var img = imgv.image
        var sticker = Sticker(image: imgv.image!, id: indexPath.row)
        
        addSticker(sticker)
        
    }

    func saveImage(){
        
        var image = mimgv.image!
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.drawAtPoint(CGPointZero)
        
        var scale = image.size.width / workview.frame.width
        println(scale)
        
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale)
        
        workview.layer.renderInContext(UIGraphicsGetCurrentContext())
        var tmpimage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();

        
        
        var result = ResultViewController()
        result.img = tmpimage
        self.navigationController?.pushViewController(result, animated: true)
        UIImageWriteToSavedPhotosAlbum(tmpimage, nil, nil, nil)

        return
        var rect = CGRect(x: 0, y: 64, width: mw, height: mh-64-100)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        
        var context = UIGraphicsGetCurrentContext()
        //CGContextRotateCTM(context, CGFloat( M_PI))


        //CGContextTranslateCTM(context, rect.width   ,rect.height);
        //CGContextDrawImage(context, rect, mimgv.image?.CGImage)
        UIImage(CGImage: CGImageCreateWithImageInRect(mimgv.image?.CGImage, rect))?.drawInRect(rect)
        
        for stickerView in self.stickerViewArray {
            CGContextSaveGState(context)
            
            var view = stickerView
            CGContextTranslateCTM(context, view.center.x, view.center.y)
            CGContextConcatCTM(context, view.transform)
            
            CGContextTranslateCTM(context,
                view.bounds.size.width * view.layer.anchorPoint.x,
                view.bounds.size.height * view.layer.anchorPoint.y
            )
            view.layer.renderInContext(UIGraphicsGetCurrentContext())
            
            CGContextRestoreGState(context)
        }
        var ret = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        //var result = ResultViewController()
        result.img = ret
        self.navigationController?.pushViewController(result, animated: true)
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
