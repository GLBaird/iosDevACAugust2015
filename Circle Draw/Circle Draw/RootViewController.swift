//
//  RootViewController.swift
//  Circle Draw
//
//  Created by Leon Baird on 26/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, ColorMixerViewControllerDelegate {

    // outlets
    @IBOutlet weak var circleView: CircleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "saveData:",
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil
        )
        
        
    }
    
    func loadData() {
        let settings = NSUserDefaults.standardUserDefaults()
        if let color = settings.objectForKey("color") as? UIColor {
            circleView.circleColor = color
            circleView.position.x = CGFloat(settings.floatForKey("x"))
            circleView.position.y = CGFloat(settings.floatForKey("y"))
            circleView.setNeedsDisplay()
        }
    }
    
    func saveData(notice:NSNotification) {
        println("Saving..")
        let settings = NSUserDefaults.standardUserDefaults()
        settings.setObject(circleView.circleColor, forKey: "color")
        settings.setFloat(Float(circleView.position.x), forKey: "x")
        settings.setFloat(Float(circleView.position.y), forKey: "y")
        settings.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ColorMixer" {
            
            var mixer = segue.destinationViewController as! ColorMixerViewController
            
            mixer.colorMixed = circleView.circleColor
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                mixer.delegate = self
                
            }
            
        }
        
    }
    
    // Unwind segue
    
    @IBAction func closeColorMixer(segue:UIStoryboardSegue) {
        var mixer = segue.sourceViewController as! ColorMixerViewController
        circleView.circleColor = mixer.colorMixed
        circleView.setNeedsDisplay()
    }
    
    // MARK: - Delegate methods
    
    func colorMixerMixedNewColor(color: UIColor) {
        circleView.circleColor = color
        circleView.setNeedsDisplay()
    }
    

}




