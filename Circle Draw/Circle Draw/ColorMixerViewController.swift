//
//  ColorMixerViewController.swift
//  Circle Draw
//
//  Created by Leon Baird on 26/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit

let ColorMixerChangedColorNotification = "com.leonbaird.colormixer.color-changed"
let ColorMixerColorKey = "color"
class ColorMixerViewController: UIViewController {
    
    var colorMixed:UIColor!
    
    // Delegate for realtime update on color being mixed
    var delegate:ColorMixerViewControllerDelegate?

    // outlets
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if colorMixed != nil {
            
            colorPreview?.backgroundColor = colorMixed
            
            // get component values
            var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0
            
            colorMixed.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
            sliderRed.value = Float(red)
            sliderGreen.value = Float(green)
            sliderBlue.value = Float(blue)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func sliderChangedValue(sender: AnyObject) {
        colorMixed = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1.0
        )
        
        colorPreview.backgroundColor = colorMixed
        
        // let delegate know color has changed
        delegate?.colorMixerMixedNewColor(colorMixed)
        
        // post notification
        let info = [ColorMixerColorKey: colorMixed]
        NSNotificationCenter
              .defaultCenter()
              .postNotificationName(
                ColorMixerChangedColorNotification,
                object: self,
                userInfo: info
        )
    }

}


protocol ColorMixerViewControllerDelegate {
    
    func colorMixerMixedNewColor(color:UIColor)
    
}
