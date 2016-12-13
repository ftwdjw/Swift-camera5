//
//  ViewController.swift
//  swiftCamera5
//
//  Created by John Mac on 12/13/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//
//1.  Verify that the device is capable of picking content from the desired source. Do this by callingthe isSourceTypeAvailable(_:) class method, providing a constant from theUIImagePickerControllerSourceType enumeration.2. Check which media types are available for the source type you’re using, by calling theavailableMediaTypes(for:) class method. This lets you distinguish between a camera thatcan be used for video recording and one that can be used only for still images.3. Tell the image picker controller to adjust the UI according to the media types you want to makeavailable—still images, movies, or both—by setting the mediaTypes property.4. Present the user interface. On iPhone or iPod touch, do this modally (full-screen) by calling thepresent(_:animated:completion:) method of the currently active view controller,passing your configured image picker controller as the new view controller.


import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    let picker = UIImagePickerController()
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Camera(_ sender: Any) {
         print("camera button hit")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        picker.allowsEditing = false
                        picker.sourceType = UIImagePickerControllerSourceType.camera
                        picker.cameraCaptureMode = .photo
                        picker.modalPresentationStyle = .fullScreen
                        present(picker,animated: true,completion: nil)
                    } else {
                        noCamera()
                    }

    }
    
    
    @IBAction func Library(_ sender: UIBarButtonItem) {
         print("library button hit")
        
        picker.allowsEditing = false
                picker.sourceType = .photoLibrary
                picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                picker.modalPresentationStyle = .popover
                present(picker, animated: true, completion: nil)
                picker.popoverPresentationController?.barButtonItem = sender
    }
    
    
    @IBAction func Save(_ sender: Any) {
         print("save button hit")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        //        let alert = UIAlertView(title: "Wow",
        //                                message: "Your image has been saved to Photo Library!",
        //                                delegate: nil,
        //                                cancelButtonTitle: "Ok")
        //                                alert.show()
        
        let tapAlert = UIAlertController(title: "Wow", message: "Your image has been saved to Photo Library!", preferredStyle: UIAlertControllerStyle.alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(tapAlert, animated: true, completion: nil)
        

    }
    
    func noCamera(){
                let alertVC = UIAlertController(
                    title: "No Camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                present(
                    alertVC,
                    animated: true,
                    completion: nil)
            }
    
    //MARK: - Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
//        {
            var  chosenImage = UIImage()
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            imageView.contentMode = .scaleAspectFit //3
            imageView.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
    
    
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }


}

