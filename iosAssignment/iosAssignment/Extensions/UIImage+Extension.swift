//
//  UIImage+Extension.swift
//  GoferDeliveryCustomer
//
//  Created by C100-104 on 05/02/20.
//  Copyright © 2020 C100-104. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
        
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
    
    func makeBlurImage(targetImageView:UIImageView?) {
        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .regular)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }

        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.alpha = 0.9
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
    
    func pixlerateImage() {
        guard let currentCGImage = self.image?.cgImage else { return }
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIBoxBlur")
        filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
        //filter?.setValue(22, forKey: kCIInputScaleKey)
        filter?.setValue(50, forKey: kCIInputRadiusKey)
        guard let outputImage = filter?.outputImage else { return }

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.image? = processedImage.cropped()
           // self.image = processedImage
        }
    }

//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
}
extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 0.5) else { return nil }// pngData()
        
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    func pixlerateImage() -> UIImage {
        guard let currentCGImage = self.cgImage else { return self}
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIBoxBlur")
        filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
        //filter?.setValue(22, forKey: kCIInputScaleKey)
        filter?.setValue(50, forKey: kCIInputRadiusKey)
        guard let outputImage = filter?.outputImage else { return self}

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
        }
        return self
    }
    
    open func cropped(/*to rect: CGRect*/) -> UIImage {
        // a UIImage is either initialized using a CGImage, a CIImage, or nothing
        let rect = CGRect(x: 30.0, y: 30.0, width: self.size.width - 60.0, height: self.size.height - 60.0)
        if let cgImage = self.cgImage {
            // CGImage.cropping(to:) is magnitudes faster than UIImage.draw(at:)
            
            if let cgCroppedImage = cgImage.cropping(to: rect) {
                return UIImage(cgImage: cgCroppedImage)
            } else {
                return UIImage()
            }
        }
        if let ciImage = self.ciImage {
            // Core Image's coordinate system mismatch with UIKit, so rect needs to be mirrored.
            var ciRect = rect
            ciRect.origin.y = ciImage.extent.height - ciRect.origin.y - ciRect.height
            let ciCroppedImage = ciImage.cropped(to: ciRect)
            return UIImage(ciImage: ciCroppedImage)
        }
        return self
    }
    
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
