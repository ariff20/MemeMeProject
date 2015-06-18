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
    func textFieldDidBeginEditing(texfieldtop: UITextField!,textfieldbottom : UITextField!) {
        texfieldtop.textColor = UIColor.whiteColor()
        textfieldbottom.textColor = UIColor.whiteColor()
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
        imagePickerView.contentMode = .ScaleAspectFit
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
    
    func save(){
        var meme = MemeObject(TextField : texfieldtop.text ,TextField2 : textfieldbottom.text  ,Image : imagePickerView.image! , memedImage : generateMemedImage())
        
        
          (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
        
    
 
    }
    
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.toolbarHidden = false
        return memedImage
    }

 
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
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

