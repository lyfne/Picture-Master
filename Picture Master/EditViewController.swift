//
//  EditViewController.swift
//  Picture Master
//
//  Created by Fan's Mac on 16/8/5.
//  Copyright © 2016年 Lifestyle Studio. All rights reserved.
//

import UIKit
import QuartzCore

class EditViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editPhotoImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    var photoImage: UIImage = UIImage()
    var toolBarVC: ToolBarViewController = ToolBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editPhotoImageView.image = photoImage
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = 1.0;
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        toolBarVC = storyboard.instantiateViewControllerWithIdentifier("ToolBarViewController") as! ToolBarViewController
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditViewController.scrollViewDoubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        let scrollViewFrame = scrollView.frame
        
        scrollView.contentSize = CGSize(width: scrollViewFrame.size.width, height: scrollViewFrame.size.height)
        
        centerScrollViewContents()
        
        toolBarVC.view.frame = CGRectMake(20, self.view.frame.size.height - 20 - 42, 42, 42)
        
        self.view.addSubview(toolBarVC.view)
        self.view.bringSubviewToFront(toolBarVC.view)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
        _ = self.navigationController?.popViewControllerAnimated(false)
    }
    
    // MARK: - Scroll View
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return editPhotoImageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.locationInView(self.editPhotoImageView)
        
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        if newZoomScale == scrollView.maximumZoomScale {
            return
        }
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = editPhotoImageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        editPhotoImageView.frame = contentsFrame
    }
    
    // MARK: - Action
    
    @IBAction func export(sender: UIButton) {
        
    }
    
    // MARK: - Public Function
    
    func setPhoto(image: UIImage?) {
        if image != nil {
            self.photoImage = image!
        }
    }
    
    // MARK: - Private Function
    
    func updateUndoRedoStatus() {
        
    }
}
