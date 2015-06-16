//
//  ViewMemePhotoViewController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/16/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class ViewMemePhotoViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func btnCancel(sender: AnyObject) {
        println("cancel")
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    @IBAction func btnTrash(sender: AnyObject) {
        println("trash")
        
    }
    @IBAction func sharing(sender: AnyObject) {
    }
    @IBOutlet weak var imgview: UIImageView!
    
    var viewmemedimage : MemeObject
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
