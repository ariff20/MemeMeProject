//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/15/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource {
    
    
    var memel: [MemeObject]!
    
    
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memel = appDelegate.memes
        
        self.tabBarController?.tabBar.hidden = false
    }
     override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
        
        
    }
    ////Reserves the number of cells needed to display the image
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memel.count
    }
    
    //Reserves the cell to be dequeued for display
     func collectionView(collectionview: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
        {
            let cell = collectionview.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as CollectionViewCell
            let memezcell =  self.memel[indexPath.item]
            cell.imageviews.image =  memezcell.memedImage
        
        return cell
    }
    //Method to do something when the cell is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailControllers = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenMeme") as FullScreenMeme
        detailControllers.meme = memel[indexPath.row]
        self.navigationController!.pushViewController(detailControllers, animated: true)
    }
    
    
    
}
