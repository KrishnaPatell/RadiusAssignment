//
//  UITextField+Extensions.swift
//  GoferDeliveryCustomer
//
//  Created by C100-104 on 27/12/19.
//  Copyright © 2019 C100-104. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
	
	func setLeftRightPadding(_ size : CGFloat)  {
		let leftpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: frame.height))
		let rightpaddingView = UIView(frame: CGRect(x: frame.width - size, y: 0, width: size, height: frame.height))
		leftView = leftpaddingView
		rightView = rightpaddingView
		leftViewMode = .always
		rightViewMode = .always
	}
	
	func setLeftPadding(_ size : CGFloat)  {
		let leftpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: frame.height))
		leftView = leftpaddingView
		leftViewMode = .always
	}
	func setRightPadding(_ size : CGFloat)  {
		let rightpaddingView = UIView(frame: CGRect(x: frame.width - size, y: 0, width: size, height: frame.height))
		rightView = rightpaddingView
		rightViewMode = .always
	}
    
    func applyBorder(borderColour: CGColor = UIColor.gray.cgColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColour
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = clipsToBounds
    }
    
    func ChangePlaceholderColor(color : UIColor) {
        let strplaceholderText = self.placeholder
        var str: NSAttributedString? = nil
        str = NSAttributedString(string: strplaceholderText ?? "", attributes: [
                NSAttributedString.Key.foregroundColor: color
                ])
        self.attributedPlaceholder = str
    }
    func ChangePlaceholderFont(font : UIFont) {
        let strplaceholderText = self.placeholder
        var str: NSAttributedString? = nil
        str = NSAttributedString(string: strplaceholderText ?? "", attributes: [
                NSAttributedString.Key.font: font
                ])
        self.attributedPlaceholder = str
    }
    
    func addImageToRight(img : UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8 , y: 8, width: 19, height: 19)) // set your Own size
        iconView.image = img
        iconView.contentMode = .scaleAspectFit
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        iconContainerView.addSubview(iconView)
        self.rightView = iconContainerView
        self.rightViewMode = .always
          
    }
    
    func addImageToLeft(img : UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8 , y: 8, width: 19, height: 19)) // set your Own size
        iconView.image = img
        iconView.contentMode = .scaleAspectFit
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
    }
    
    func addImageToRightForRoom(img : UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8 , y: 8, width: 14, height: 14)) // set your Own size
        iconView.image = img
        iconView.contentMode = .scaleAspectFit
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        iconContainerView.addSubview(iconView)
        self.rightView = iconContainerView
        self.rightViewMode = .always
          
    }
}
extension UITextView {
    func applyBorder(borderColour: CGColor = UIColor.gray.cgColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColour
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = clipsToBounds
    }
    
    func setRightPadding(_ size : CGFloat) {
       // let rightpaddingView = UIView(frame: CGRect(x: frame.width - size, y: 0, width: size, height: frame.height))
        contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: size)
    }
    
    func setLeftPadding(_ size : CGFloat)  {
          contentInset = UIEdgeInsets(top: 5, left: size, bottom: 5, right: 5)
    }
    
    func setLeftRightPadding(leftSize : CGFloat, rightSize : CGFloat)  {
        contentInset = UIEdgeInsets(top: 5, left: leftSize, bottom: 5, right: rightSize)
    }
}


