//
//  ViewController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/11/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    
    //override func viewWillAppear(animated:true) {
        //self.viewWillAppear(animated)
       // let cameraButton = pickAnImageFromCamera(<,#sender: AnyObject#>))
        //cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    

    @IBAction func pickAnImage(sender: AnyObject) {
    
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickercontroller, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        imagePickerView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePickers = UIImagePickerController()
        imagePickers.delegate = self
        imagePickers.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePickers, animated: true
            , completion: nil)
    }

}

