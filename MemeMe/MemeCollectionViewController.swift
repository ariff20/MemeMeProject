//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/15/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource {
    
    
    var memes: [MemeObject]!
    
    
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate as AppDelegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        self.tabBarController?.tabBar.hidden = false
    }
     override func viewDidLoad() {
        super.viewDidLoad()
        println(memes)
        super.viewDidLoad()
        title = "Funniest Collection In Town"
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
     func collectionView(collectionview: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
        {
            let cell = collectionview.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as CollectionViewCell
           // let memezcell = memes[indexPath.item]
            //cell.setText(memezcell.TextField, bottomString : memezcell.TextField2)
            //cell.backgroundColor = UIColor.redColor()
            //let imageView = UIImageView(image: memezcell.Image)
            //cell.backgroundView = (named: imageView)
            
    
            let memezcell =  self.memes[indexPath.item]
            cell.imageviews.image =  (named: memezcell.memedImage)
        
        return cell
    }
    
    
}
