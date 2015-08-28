//
//  Place.swift
//  PlacesOfInterest
//
//  Created by Leon Baird on 28/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import Foundation
import CoreData
import MapKit

// Constants
let PlaceEntityName = "Place"
let PlaceAttributeName = "name"
let PlaceAttributeDate = "date"

class Place: NSManagedObject, MKAnnotation {

    @NSManaged var name: String
    @NSManaged var date: NSTimeInterval
    @NSManaged var imagePath: String
    @NSManaged var geoLong: Double
    @NSManaged var geoLat: Double
    
    var coordinate:CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geoLat, longitude: geoLong)
    }
    
    var title:String {
        return name
    }
    
    var subtitle:String {
        return "Date visited: \(getLongDate())"
    }
    
    func getDate() -> NSDate {
        return NSDate(timeIntervalSince1970: date)
    }
    
    func getLongDate() -> String {
        return NSDateFormatter.localizedStringFromDate(
            self.getDate(),
            dateStyle: .LongStyle,
            timeStyle: .NoStyle
        )
    }
    
    func deleteImage() {
        let path = NSHomeDirectory() + imagePath
        let fm = NSFileManager.defaultManager()
        if !imagePath.isEmpty && fm.fileExistsAtPath(path) {
            var error:NSError?
            if !fm.removeItemAtPath(path, error: &error) {
                NSLog("Failed to delete image at path \(path)\n" +
                    "For reason: \(error?.localizedDescription)")
            }
        }
    }
}
