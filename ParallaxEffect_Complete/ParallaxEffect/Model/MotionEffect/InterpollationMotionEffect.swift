//
//  InterpollationMotionEffect.swift
//  ParallaxEffect
//
//  Created by Vishal Mishra, Gagan on 15/10/15.
//  Copyright (c) 2015 Vishal Mishra, Gagan. All rights reserved.
//

/*---------------------------------------------------A SubClass of UIMotionEffect to detect & measure motion effect on each cell of UITableView. For more info : https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIMotionEffect_class/ ------------------------------------------*/

import UIKit

class InterpollationMotionEffect: UIMotionEffect {
    var keyPath : String?
    var type : UIInterpolatingMotionEffectType?
    var minimumRelativeValue : CGFloat = 0.0
    var maximumRelativeValue : CGFloat = 0.0
    
    //MARK:- Init for the class with effect type & relative motion values 
    init(keyPath : String, type : UIInterpolatingMotionEffectType , minimumRelativeValue : CGFloat, maximumRelativeValue : CGFloat) {
        super.init()
        self.type = type
        self.keyPath = keyPath
        self.minimumRelativeValue = minimumRelativeValue
        self.maximumRelativeValue = maximumRelativeValue
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.minimumRelativeValue = CGFloat ( aDecoder .decodeObjectForKey("minimumRelativeValue")! as! NSNumber )
        self.maximumRelativeValue = CGFloat(aDecoder .decodeObjectForKey("maximumRelativeValue")! as! NSNumber)
        self.type = aDecoder.decodeObjectForKey("EffectType") as? UIInterpolatingMotionEffectType
        self.keyPath = aDecoder.decodeObjectForKey("keyPath") as? String
    }
    
     override func copyWithZone(zone: NSZone) -> AnyObject {
        
        if let logarithmicEffect : InterpollationMotionEffect = super.copyWithZone(zone) as? InterpollationMotionEffect
        {
          logarithmicEffect.maximumRelativeValue = self.maximumRelativeValue
          logarithmicEffect.minimumRelativeValue = self.minimumRelativeValue
          logarithmicEffect.type = self.type
          logarithmicEffect.keyPath = self.keyPath
          return logarithmicEffect
        }
        else
        {
            let logarithmicEffect : InterpollationMotionEffect = (super.copyWithZone(zone) as? InterpollationMotionEffect)!
            return logarithmicEffect
        }
    }

    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        let minimumValue : AnyObject = self.minimumRelativeValue
        let maximumRelativeValue : AnyObject = self.maximumRelativeValue
        aCoder.encodeObject(minimumValue, forKey: "minimumRelativeValue")
        aCoder.encodeObject(maximumRelativeValue, forKey: "maximumRelativeValue")
        aCoder.encodeObject(self.type as? AnyObject, forKey: "EffectType")
        aCoder.encodeObject(self.keyPath, forKey: "keyPath")
    }
    
    
    // MARK:- keyPathsAndRelativeValuesForViewerOffset: By overriding the method and returning one or more key paths representing the view properties to modify.
    override func keyPathsAndRelativeValuesForViewerOffset(viewerOffset: UIOffset) -> [String : AnyObject]? {
        var motionAmplitute : CGFloat = 0.0
        //Detect motion direction vertical or Horizontal
        if .TiltAlongHorizontalAxis == self.type
        {
            motionAmplitute = viewerOffset.horizontal
        }
        else
        {
            motionAmplitute = viewerOffset.vertical
        }
        
        
        if motionAmplitute > 0
        {
            let maximumValue = self.maximumRelativeValue
            let idObject : AnyObject? = motionAmplitute * maximumValue/4
            return [ self.keyPath! as NSObject as! String:  idObject!]
        }
        else
        {
            let minimumValue = self.minimumRelativeValue
            let idObject : AnyObject?  = -motionAmplitute*minimumValue/4
            return [self.keyPath! as NSObject as! String: idObject!]
        }
    }
  
 }
