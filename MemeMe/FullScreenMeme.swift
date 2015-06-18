//
//  FullScreenMeme.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/18/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class FullScreenMeme : UIViewController{
    
    
    @IBOutlet weak var ImageView: UIImageView!
    var meme : MemeObject!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
        self.ImageView.image = meme.memedImage
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
}
