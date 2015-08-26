//
//  CircleView.swift
//  Circle Draw
//
//  Created by Leon Baird on 26/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    // circle properties
    var position:CGPoint!
    var diameter:CGFloat = 100.0
    var circleColor = UIColor.blueColor()

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        if position == nil {
            position = CGPoint(x: bounds.width/2, y: bounds.height/2)
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                diameter = 200.0
            }
        }
        
        var context = UIGraphicsGetCurrentContext()
        
        circleColor.setFill()
        
        // make rect for drawing
        let circleRect = CGRect(
            x: position.x - diameter / 2,
            y: position.y - diameter / 2,
            width: diameter,
            height: diameter
        )
        
        CGContextSetShadowWithColor(context, CGSize(width: 3.0, height: 3.0), 5.0, UIColor.blackColor().CGColor)
        
        CGContextFillEllipseInRect(context, circleRect)
        
    }
    
    // Responder methods
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if touches.count == 1 {
            let touch = touches.first as! UITouch
            position = touch.locationInView(self)
            self.setNeedsDisplay()
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        self.touchesBegan(touches, withEvent: event)
    }
    

}
