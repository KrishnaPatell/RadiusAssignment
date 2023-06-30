//
//  Utils.swift
//  UIDesign
//
//  Created by C100-174 on 29/05/23.
//

import Foundation
import UIKit
import CoreTelephony
import SVProgressHUD

//MARK: - DESIGN FUNCTIONS
func calculateForWidth(size : CGFloat) -> CGFloat {
    return (SCREEN_WIDTH * size)/SCREEN_WIDTH_FOR_ORIGINAL_FONT
}

func calculateForHeight(size : CGFloat) -> CGFloat {
    return (SCREEN_HEIGHT * size)/SCREEN_HEIGHT_FOR_ORIGINAL_FONT
}

func scaleFont(byWidth control: UIView?) {
    if (control is UILabel) {
        (control as? UILabel)?.adjustsFontSizeToFitWidth = true
        (control as? UILabel)?.minimumScaleFactor = 0.5
        (control as? UILabel)?.baselineAdjustment = .alignCenters
        (control as? UILabel)?.lineBreakMode = .byClipping
    } else if (control is UIButton) {
        (control as? UIButton)?.titleLabel?.adjustsFontSizeToFitWidth = true
        (control as? UIButton)?.titleLabel?.minimumScaleFactor = 0.5
        (control as? UIButton)?.titleLabel?.baselineAdjustment = .alignCenters
        (control as? UIButton)?.titleLabel?.lineBreakMode = .byClipping
    } else if (control is UITextField) {
        (control as? UITextField)?.adjustsFontSizeToFitWidth = true
        (control as? UITextField)?.minimumFontSize = 0.5
    }
}

//MARK: - COMMON
func getCurrentVersion() -> String?{
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

func getCurrentBuildNumber() -> String?{
    Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

func postNotification(withName : String, object : Any? = nil, userInfo : [String : Any]? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name(withName), object: object, userInfo: userInfo)
}

func getVersion() -> String {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    return appVersion
}

//MARK: - CHANGE PLACEHOLDER COLOR
func changePlaceholderColor(_ txtField: UITextField?, placecolor color: UIColor?) {
    let strplaceholderText = txtField?.placeholder
    var str: NSAttributedString? = nil
    if let color = color {
        str = NSAttributedString(string: strplaceholderText ?? "", attributes: [
            NSAttributedString.Key.foregroundColor: color
            ])
    }
    txtField?.attributedPlaceholder = str
}

//MARK: - SET IMAGE TINT COLOR
func setImageViewTintColor(img : UIImageView, color: UIColor) -> UIImage {
    img.image =  img.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    img.tintColor = color
    return (img.image ?? nil)!
}

func setImageTintColor(image: UIImage?, color: UIColor?) -> UIImage? {
    if (image?.size.height ?? 0.0) > 0 && (image?.size.width ?? 0.0) > 0 {
        var newImage: UIImage? = image?.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(image?.size ?? CGSize.zero, _: false, _: newImage?.scale ?? 0.0)
        color?.set()
        newImage?.draw(in: CGRect(x: 0, y: 0, width: image?.size.width ?? 0.0, height: newImage?.size.height ?? 0.0))
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    } else {
        return image
    }
}

//MARK: - SOME FUNCTION RELATED TO BORDER, CORNERS
func makeCircular(view : UIView) {
    view.layer.cornerRadius = view.frame.size.height/2
    view.layer.masksToBounds = true
}

func drawBorder(view: UIView?, color borderColor: UIColor?, width: Float, radius: Float) {
    view?.layer.borderColor = borderColor?.cgColor
    view?.layer.borderWidth = CGFloat(width)
    view?.layer.cornerRadius = CGFloat(radius)
    view?.layer.masksToBounds = true
}

func drawBorder1(view: UIView?, color borderColor: UIColor?, width: Float, radius: Float) {
    view?.layer.borderColor = borderColor?.cgColor
    view?.layer.borderWidth = CGFloat(width)
    view?.layer.cornerRadius = CGFloat(radius)
    // view?.layer.masksToBounds = true
}

func drawShadow(view : UIView, color : UIColor) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.shadowRadius = 3.0
    view.layer.shadowOpacity = 1.0
    view.layer.masksToBounds = false
}

func roundingCorners(_ view: UIView?, byRoundingCorners Corners: UIRectCorner, size Points: CGSize, borderColor : UIColor, borderWidth : CGFloat) {
    let maskPath = UIBezierPath(roundedRect: view?.bounds ?? CGRect.zero, byRoundingCorners: Corners, cornerRadii: Points)
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view?.bounds ?? CGRect.zero
    maskLayer.path = maskPath.cgPath
    view?.layer.borderColor = borderColor.cgColor
    view?.layer.borderWidth = borderWidth
    view?.layer.mask = maskLayer
    view?.layer.masksToBounds = true
}

func secondsToHoursMinutesSeconds (seconds : Double) -> (Double, Double, Double) {
  let (hr,  minf) = modf (seconds / 3600)
  let (min, secf) = modf (60 * minf)
  return (hr, min, 60 * secf)
}


//MARK:- USERDEFAULT FUNCTIONS
func isKeyPresentInUserDefaults(key: String) -> Bool {
    return USER_DEFAULTS.object(forKey: key) != nil
}


//MARK: - OTHERS

func showLoader() {
    SVProgressHUD.show()
}
func hideLoader() {
    SVProgressHUD.dismiss()
}


