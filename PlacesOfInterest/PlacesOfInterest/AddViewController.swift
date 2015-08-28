//
//  AddViewController.swift
//  PlacesOfInterest
//
//  Created by Leon Baird on 28/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddViewController: UIViewController,
            UIImagePickerControllerDelegate,
            UINavigationControllerDelegate,
            CLLocationManagerDelegate,
            UITextFieldDelegate
{
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!
    
    // For location services
    var locationManager:CLLocationManager! = CLLocationManager()
    var location:CLLocation?

    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Listen for keyboard to appear
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardAppearing",
            name: UIKeyboardWillShowNotification,
            object: nil
        )
        
        // request location
        
        if CLLocationManager.locationServicesEnabled() {
        
            locationManager.requestWhenInUseAuthorization()
            
            switch CLLocationManager.authorizationStatus() {
                case .AuthorizedWhenInUse, .NotDetermined:
                    locationManager.delegate = self
                    locationManager.distanceFilter = 100
                    locationManager.startUpdatingLocation()
                
                default:
                    locationManager = nil
            }
            
        } else {
            let msg = UIAlertController(
                title: "Location Services Disables",
                message: "This app uses location services to tag your place on a map. Please enable location services.",
                preferredStyle: .Alert
            )
            
            msg.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .Cancel,
                    handler: { (alert) -> Void in
                        navigationController?.popViewControllerAnimated(true)
                })
            )
            
            presentViewController(msg, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    func keyboardAppearing() {
        let done = UIBarButtonItem(
            barButtonSystemItem: .Done,
            target: self,
            action: "closeKeyboard"
        )
        
        navigationItem.setRightBarButtonItem(done, animated: true)
    }
    
    func closeKeyboard() {
        nameTextField.resignFirstResponder()
        navigationItem.setRightBarButtonItem(nil, animated: true)
    }
    
    @IBAction func pickImageSource(sender: AnyObject) {
        let choice = UIAlertController(
            title: "Pick Image",
            message: "Choose image source:",
            preferredStyle: .ActionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            choice.addAction(
                UIAlertAction(
                    title: "Camera",
                    style: .Default,
                    handler: { (alert) -> Void in
                        self.pickImageFromSource(.Camera)
                })
            )
        }
        
        choice.addAction(
            UIAlertAction(
                title: "Photo Library",
                style: .Default,
                handler: { (alert) -> Void in
                    self.pickImageFromSource(.PhotoLibrary)
            })
        )
        
        choice.addAction(
            UIAlertAction(
                title: "Camera Roll",
                style: .Default,
                handler: { (alert) -> Void in
                    self.pickImageFromSource(.SavedPhotosAlbum)
            })
        )
        
        choice.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .Cancel,
                handler: nil
            )
        )
        
        presentViewController(choice, animated: true, completion: nil)
    }
    
    func pickImageFromSource(source:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func clearForm(sender: AnyObject) {
        nameTextField.text = ""
        imagePreview.image = UIImage(named: "Camera")
        imagePreview.contentMode = .Center
        imagePreview.tag = 0
    }

    @IBAction func savePlace(sender: AnyObject) {
        if nameTextField.text.isEmpty {
            let alert = UIAlertController(
                title: "Error",
                message: "You need a place name",
                preferredStyle: .Alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .Cancel,
                    handler: nil
                )
            )
            
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // make new item in Core Data
        let newPlace = NSEntityDescription.insertNewObjectForEntityForName(PlaceEntityName, inManagedObjectContext: AppDelegate.getContext()) as! Place
        newPlace.name = nameTextField.text
        newPlace.date = NSDate().timeIntervalSince1970
        
        if let loc = location {
            newPlace.geoLat = loc.coordinate.latitude
            newPlace.geoLong = loc.coordinate.longitude
        }
        
        newPlace.imagePath = ""
        
        if imagePreview.tag == 1 {
            var filename = "/Documents/img-\(newPlace.date).jpg"
            var path = NSHomeDirectory() + filename
            
            if let imageData = UIImageJPEGRepresentation(imagePreview.image, 1.0) {
                if imageData.writeToFile(path, atomically: true) {
                    newPlace.imagePath = filename
                } else {
                    NSLog("Failed to save to path: \(path)")
                }
            }
            
        }
        
        AppDelegate.getDelegate().saveContext()
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Image Picker Delegate Method
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imagePreview.image = image
        imagePreview.contentMode = UIViewContentMode.ScaleAspectFit
        imagePreview.tag = 1
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - CLLocation Manager Delegate Method
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Location found")
        
        location = locations.last as? CLLocation
        
        println(" Coordinates: \(location?.coordinate)")
    }
    
    // MARK: - UITextField Delegate Method
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }
    
    
}
