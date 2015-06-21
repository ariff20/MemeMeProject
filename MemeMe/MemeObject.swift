//
//  MemeObject.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/12/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import Foundation
import UIKit

struct MemeObject
{
    var textField : String
    var textField2 : String
    var image : UIImage
    var memedImage : UIImage
  
    init(textField : String! , textField2 : String! , image : UIImage! , memedImage : UIImage! ){
        
        self.textField = textField
        self.textField2 = textField2
        self.image = image
        self.memedImage = memedImage
    }
}

    

    
    

