//
//  ViewController.swift
//  Picture Master
//
//  Created by Fan's Mac on 16/8/4.
//  Copyright © 2016年 Lifestyle Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditPhoto" {
            let editVC = segue.destinationViewController as! EditViewController
            editVC.setPhoto(self.image)
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal")
        }
    }
    
    @IBAction func unwindToPhotoSelection(sender: UIStoryboardSegue) {
        
    }
    
    //MARK: Action
    
    @IBAction func takePhoto(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: {() -> Void in
            })
        } else {
            print("Can't find camera")
        }
    }
    
    @IBAction func selectPicture(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Image Picker Delegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.image = image
        if (self.image as UIImage!) != nil{
            performSegueWithIdentifier("EditPhoto", sender: self)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}

