//
//  ListTableViewController.swift
//  PlacesOfInterest
//
//  Created by Leon Baird on 28/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    var fetchedResults:NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data from CoreData
        let request = NSFetchRequest(entityName: PlaceEntityName)
        request.sortDescriptors = [
            NSSortDescriptor(key: PlaceAttributeName, ascending: true),
            NSSortDescriptor(key: PlaceAttributeDate, ascending: true)
        ]
    
        fetchedResults = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.getContext(),
            sectionNameKeyPath: nil,
            cacheName: "places"
        )
        
        var error:NSError?
        if !fetchedResults.performFetch(&error) {
            NSLog("Failed to load requests from Core Data \(error):\n\(error?.localizedDescription)")
            fetchedResults = nil
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        if fetchedResults == nil || fetchedResults.sections == nil {
            return 0
        }
        
        return fetchedResults.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        let info = fetchedResults.sections![section] as! NSFetchedResultsSectionInfo
        
        return info.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as! PlaceTableViewCell

        let place = fetchedResults.objectAtIndexPath(indexPath) as! Place
        
        // Configure the cell...
        
        cell.nameLabel.text = place.name
        cell.dateLabel.text = place.getLongDate()
        
        if !place.imagePath.isEmpty {
            let path = NSHomeDirectory() + place.imagePath
            cell.imagePreview.image = UIImage(contentsOfFile: path)
            cell.imagePreview.contentMode = UIViewContentMode.ScaleAspectFill
            cell.imagePreview.clipsToBounds = true
        } else {
            cell.imagePreview.image = UIImage(named: "Camera")
            cell.imagePreview.contentMode = UIViewContentMode.Center
        }

        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            let place = fetchedResults.objectAtIndexPath(indexPath) as! Place
            place.deleteImage()
            AppDelegate.getContext().deleteObject(place)
            fetchedResults.performFetch(nil)
            
            // update table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let place = fetchedResults.objectAtIndexPath(tableView.indexPathForSelectedRow()!) as! Place
        
        let mapVC = segue.destinationViewController as! MapViewController
        
        mapVC.place = place
    }
    

}
