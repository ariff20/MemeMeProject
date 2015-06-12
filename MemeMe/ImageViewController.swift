//
//  ViewController.swift
//  MemeMe
//
//  Created by Sharifah Nazreen Ashraff ali on 6/11/15.
//  Copyright (c) 2015 SyedAriff. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var texfieldtop: UITextField!
    @IBOutlet weak var textfieldbottom: UITextField!
    
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 5.00
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardHideNotifications()
        //cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    override func  viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribefromKeyboardNotifications()
        self.unsubscribefromKeyboardHideNotifications()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissViewControllerAnimated(true, completion: nil)
        texfieldtop.defaultTextAttributes = memeTextAttributes
        textfieldbottom.defaultTextAttributes = memeTextAttributes
        texfieldtop.delegate = self
        textfieldbottom.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldDidBeginEditing(texfieldtop: UITextField!,textfieldbottom : UITextField!) {
        texfieldtop.placeholder = nil
        textfieldbottom.placeholder = nil
    }
    func textFieldShouldReturn(texfieldtop: UITextField) -> Bool {
        
        texfieldtop.resignFirstResponder()
        
        return true
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
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(notifications: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notifications)
    }
    func getKeyboardHeight(notification: NSNotification)->CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }
    func subscribeToKeyboardHideNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribefromKeyboardHideNotifications(){
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    func unsubscribefromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
   
   

}

