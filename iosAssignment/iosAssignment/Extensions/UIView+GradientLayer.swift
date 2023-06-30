//
//  UIView+GradientLayer.swift
//  SwiftProjectStructure
//
//  Created by EbitM02 on 28/06/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import Foundation
import UIKit

enum GradientDirection : Int {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case TopLeftToBottomRight
    case TopRightToBottomLeft
    case BottomLeftToTopRight
    case BottomRightToTopLeft
}

extension UIView {
    
    func gradientBackground(ColorSet arrColor : [CGColor], direction : GradientDirection) {
        /*var arrCGColors : [CGColor] = [CGColor]()
        for color: UIColor? in arrColor {
            arrCGColors.append(color?.cgColor ?? UIColor.white.cgColor)
        }*/
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = arrColor
        gradientLayer.frame = self.bounds
        
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break;
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
            break;
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            break;
            
        case .TopLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break;
            
        case .TopRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            break;
            
        case .BottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break;
            
        case .BottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            break;
            
        default: //Default Case is Top To Bottom
            break;
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
        
      //  self.clipsToBounds = true
        
    }
    
    func gradientLayer(ColorSet arrColor : [CGColor], direction : GradientDirection) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = arrColor
        gradientLayer.frame = self.bounds
        
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break;
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
            break;
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            break;
            
        case .TopLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break;
            
        case .TopRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            break;
            
        case .BottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break;
            
        case .BottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            break;
            
        default: //Default Case is Top To Bottom
            break;
        }
        return gradientLayer
        
    }
    
    func addGradienBorder(colors:[CGColor], width:CGFloat = 1, direction : GradientDirection, radius : CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break;
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
            break;
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            break;
            
        case .TopLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break;
            
        case .TopRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            break;
            
        case .BottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break;
            
        case .BottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            break;
            
        default: //Default Case is Top To Bottom
            break;
        }
            //gradientLayer.startPoint = CGPointake(0.0, 0.5)
            //gradientLayer.endPoint = CGPointMake(1.0, 0.5)
            
        gradientLayer.colors = colors//colors.map({$0.CGColor})

        let shapeLayer = CAShapeLayer()
        shapeLayer.cornerRadius = radius
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
