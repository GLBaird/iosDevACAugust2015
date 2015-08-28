//
//  MapViewController.swift
//  PlacesOfInterest
//
//  Created by Leon Baird on 28/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import Social

class MapViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var map: MKMapView!
    
    var place:Place!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if place != nil {
            map.addAnnotation(place)
            
            map.setRegion(
                MKCoordinateRegion(
                    center: place.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.5,
                        longitudeDelta: 0.5
                    )
                ),
                animated: true
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func postToFacebook(sender: AnyObject) {
        let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        post.setInitialText("I visited \(place.title) on \(place.getLongDate())")
        post.addImage(UIImage(contentsOfFile: NSHomeDirectory() + place.imagePath))
        
        presentViewController(post, animated: true, completion: nil)
    }
    
    @IBAction func switchMapMode(sender: UIBarButtonItem) {
        map.mapType = MKMapType(rawValue: UInt(sender.tag))!
    }

}
