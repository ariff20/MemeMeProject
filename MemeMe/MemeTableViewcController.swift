//
//  MemeTableViewcController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/15/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class MemeTableViewController : UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var memesz: [MemeObject]!
    

    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memesz = appDelegate.memes
         tableView.reloadData()
    }
    override func viewDidLoad() {
         
    
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
        
    }
    
    //reserves the number of rows needed to display the image
       func tableView(tableView : UITableView, numberOfRowsInSection section : Int)->Int
       {
        
          return  memesz.count
        }
    //Reserves the row to be dequeued for display
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemesCell", forIndexPath: indexPath) as UITableViewCell
        
        let memezrow =  memesz[indexPath.row]
        println(memezrow.TextField)
        cell.textLabel?.text = memezrow.TextField
        cell.imageView?.image = memezrow.memedImage
        
            return cell
    }
    
    //Method to do something when the row is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenMeme") as FullScreenMeme
        detailController.meme = memesz[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}
