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
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
        
        let cell:TableViewzCell = tableView.dequeueReusableCellWithIdentifier("MemesCell", forIndexPath: indexPath) as! TableViewzCell
        
        let memezrow =  memesz[indexPath.row]
        cell.label1.text = memezrow.textField
        cell.label2.text = memezrow.textField2
        cell.imageview.image = memezrow.memedImage
        
            return cell
    }
    
    //Method to do something when the row is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenMeme") as! FullScreenMeme
        detailController.meme = memesz[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}
