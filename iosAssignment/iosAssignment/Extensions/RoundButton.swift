//
//  RoundButton.swift
//  Bubbles
//
//  Created by C100-107 on 16/04/20.
//  Copyright © 2020 C100-107. All rights reserved.
//

import UIKit
@IBDesignable class RoundButton: UIButton {
    
    var tableIndex : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
    }
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable
       var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue
           }
       }
       
       @IBInspectable
       var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
       @IBInspectable
       var shadowOffset: CGSize {
           get {
               return layer.shadowOffset
           }
           set {
               layer.shadowOffset = newValue
           }
       }
       
       @IBInspectable
       var shadowColor: UIColor? {
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else {
                   layer.shadowColor = nil
               }
           }
       }
}
