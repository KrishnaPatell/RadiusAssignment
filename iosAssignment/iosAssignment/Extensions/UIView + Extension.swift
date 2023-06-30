//
//  UIView + Extension.swift
//  DriverRater
//
//  Created by C100-104on 02/10/20.
//  Copyright © 2020 Narola Infotech. All rights reserved.
//

import Foundation
import UIKit
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    func dropShadow(scale: Bool = true, addPath : Bool = false) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 10
        
        if addPath {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

      // OUTPUT 2
      func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    func makeCorner(withRadius radius: CGFloat) {
          self.layer.cornerRadius = radius
          self.layer.masksToBounds = true
          self.layer.isOpaque = false
      }
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        /*
         layerMinXMinYCorner – top left corner
         layerMaxXMinYCorner – top right corner
         layerMinXMaxYCorner – bottom left corner
         layerMaxXMaxYCorner – bottom right corner
         */
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
        self.layer.maskedCorners = corners
    }
    func addDashBorder(borderColor : UIColor) {
            let color = borderColor.cgColor
            
            let shapeLayer:CAShapeLayer = CAShapeLayer()
            let frameSize = self.frame.size
            let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
            
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            shapeLayer.lineDashPattern = [6,3]
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
            
            self.layer.addSublayer(shapeLayer)
        }

    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
extension UIViewController {
    @objc func showAlert(title: String, message: String )
    {
        // create the alert
        let alert = UIAlertController(title: title  , message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @objc func showAlert(title: String, message: String, buttonText : String = "OK", completion: @escaping (UIAlertAction) -> Void)
    {
        // create the alert
        let alert = UIAlertController(title: title  , message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.cancel, handler: completion))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    static func loadFromNib() -> Self {
           func instantiateFromNib<T: UIViewController>() -> T {
               return T.init(nibName: String(describing: T.self), bundle: nil)
           }
           return instantiateFromNib()
    }

}
