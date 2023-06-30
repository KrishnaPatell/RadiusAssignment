//
//  UILabel + Extension.swift
//  DriverRater
//
//  Created by C100-104on 14/09/20.
//  Copyright © 2020 Narola Infotech. All rights reserved.
//

import Foundation
import  UIKit
extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
    
    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {

            var startColorRed:CGFloat = 0
            var startColorGreen:CGFloat = 0
            var startColorBlue:CGFloat = 0
            var startAlpha:CGFloat = 0

            if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
                return false
            }

            var endColorRed:CGFloat = 0
            var endColorGreen:CGFloat = 0
            var endColorBlue:CGFloat = 0
            var endAlpha:CGFloat = 0

            if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
                return false
            }

            let gradientText = self.text ?? ""

            //let name:String = NSAttributedString.Key.font.rawValue
            let textSize: CGSize = gradientText.size(withAttributes: [NSAttributedString.Key.font : self.font!])
            let width:CGFloat = textSize.width
            let height:CGFloat = textSize.height

            UIGraphicsBeginImageContext(CGSize(width: width, height: height))

            guard let context = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return false
            }

            UIGraphicsPushContext(context)

            let glossGradient:CGGradient?
            let rgbColorspace:CGColorSpace?
            let num_locations:size_t = 2
            let locations:[CGFloat] = [ 0.0, 1.0 ]
            let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
            rgbColorspace = CGColorSpaceCreateDeviceRGB()
            glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
            let topCenter = CGPoint.zero
            let bottomCenter = CGPoint(x: 0, y: textSize.height)
            context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)

            UIGraphicsPopContext()

            guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return false
            }

            UIGraphicsEndImageContext()

            self.textColor = UIColor(patternImage: gradientImage)

            return true
        }
}
