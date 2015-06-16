//
//  MemeTableViewcController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/15/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class MemeTableViewController : UITableViewController,UITableViewDelegate,UITableViewDataSource
{
    var memesz: [MemeObject]!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let objects = UIApplication.sharedApplication().delegate as AppDelegate
        let appDelegate = objects as AppDelegate
        memesz = appDelegate.memes
        tableView.reloadData()
    }
    override func viewDidLoad() {
        println(memesz)
        super.viewDidLoad()
        title = "Funniest Table In Town"
        
        //tableview.registerClass(UITableViewCell.self,
            //forCellReuseIdentifier: "MemeCell")
        
    }
    
    
       override func tableView(tableView : UITableView, numberOfRowsInSection section : Int)->Int
       {
          return  memesz.count
        }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")
            as UITableViewCell
        
            let memezrow =  memesz[indexPath.row]
        
            cell.textLabel?.text = memezrow.TextField
            cell.imageView?.image =  (named: memezrow.memedImage)
        
        
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewMemePhotoViewController") as ViewMemePhotoViewController
        detailController.viewmemedimage = memesz[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}
