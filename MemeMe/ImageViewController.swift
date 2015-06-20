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

    @IBOutlet weak var sharebutton: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var navbar: UINavigationBar!
    var activityViewController : UIActivityViewController?
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSBackgroundColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 5.00
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardHideNotifications()
        if imagePickerView == nil {
            sharebutton.enabled = false}
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    override func  viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribefromKeyboardNotifications()
        self.unsubscribefromKeyboardHideNotifications()
        self.navigationController?.setToolbarHidden(false, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissViewControllerAnimated(true, completion: nil)
        texfieldtop.attributedPlaceholder = NSAttributedString(string:"TOP",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        textfieldbottom.attributedPlaceholder = NSAttributedString(string:"BOTTOM",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
       
        texfieldtop.defaultTextAttributes = memeTextAttributes
        textfieldbottom.defaultTextAttributes = memeTextAttributes
        texfieldtop.delegate = self
        textfieldbottom.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Set the placeholder to nil once the user begins editing
    func textFieldDidBeginEditing(texfieldtop: UITextField!,textfieldbottom : UITextField!) {
        texfieldtop.textColor = UIColor.whiteColor()
        textfieldbottom.textColor = UIColor.whiteColor()
        texfieldtop.placeholder = nil
        textfieldbottom.placeholder = nil
        
        
        
        
    }
    //Dismiss the keyboard when the user hits return
    func textFieldShouldReturn(texfieldtop: UITextField) -> Bool {
        
        texfieldtop.resignFirstResponder()
        
        return true
    }
    
   
   //Method to choose an image from the device's album
    @IBAction func pickAnImage(sender: AnyObject) {
    
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickercontroller, animated: true, completion: nil)
    }
    
    //Setting the chosen image to a variable
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        imagePickerView.image=selectedImage
        imagePickerView.contentMode = .ScaleAspectFit
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Method to choose an image from the device's album
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePickers = UIImagePickerController()
        imagePickers.delegate = self
        imagePickers.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePickers, animated: true
            , completion: nil)
        
    }
    //Moves the view up when the keyboard appears
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    //Moves the view down when the user dismisses the keyboard
    func keyboardWillHide(notifications: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notifications)
    }
    //Gets the Keyboard Height to be substracted or added
    func getKeyboardHeight(notification: NSNotification)->CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }
    //Notifications to tell you when the keyboard appears
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
    //Generates a Meme Object
    func save(){
        var meme = MemeObject(TextField : texfieldtop.text ,TextField2 : textfieldbottom.text  ,Image : imagePickerView.image! , memedImage : generateMemedImage())
        
        
          (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
        
    
 
    }
    //Generates the memed Image
    func generateMemedImage() -> UIImage {
        
        self.navbar.hidden = true
        self.toolbar.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.navbar.hidden = false
        self.toolbar.hidden = true
        return memedImage
    }

    //dismisses the view controller
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    //Launches the activity view controller for the user to share the image
    @IBAction func share(sender: UIBarButtonItem) {
        var   memeedimage = generateMemedImage()
        
        
        let activityViewController = UIActivityViewController(activityItems:[memeedimage] , applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    
        activityViewController.completionWithItemsHandler = {
            (activity, success, returneditems, error) in
            println("Activity: \(activity) Success: \(success) Items: \(returneditems) Error: \(error)")
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        
        
            let memevc:MemeTableViewController  = MemeTableViewController()
            self.presentViewController(memevc, animated: true, completion: nil)
    }
   
    
   

}
}

