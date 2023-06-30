//
//  StringConstants.swift
//  UIDesign
//
//  Created by C100-174 on 29/05/23.
//
import Foundation
import UIKit

class StringConstants {
    
    //MARK: - VALIDATION
    static var VALIDATION_InvalidPassword : String { get { "Password must contain 8-32 characters, atleast one digit, one lower case letter, one upper case letter and one special character." }}
    static var VALIDATION_ConfirmYourPassword : String { get { "Please confirm your password." }}
    static var VALIDATION_MisMatchPassword : String { get { "Please make sure your password match."}}
    
    //MARK: - DESCRIPTION
    static var DESC_AppleLoginNotAvailable: String { get { "Apple Login is not available in your device."}}
    static var DESC_LogoutConfirmation: String { get { "Are you sure you want to logout?"}}
    static var DESC_LoginDetectedInOtherDevice: String { get { "Login detected in other device."}}
    static var DESC_MaliciousSource: String { get { "Malicious source detected."}}
    
    //MARK: - PLACEHOLDERS
    static var PLACEHOLDER_Password : String { get { "Password" }}
    static var PLACEHOLDER_Email : String { get { "Email" }}
    static var PLACEHOLDER_FirstName : String { get { "First Name" }}
    static var PLACEHOLDER_LastName : String { get { "Last Name" }}
    
    //MARK: - TAB
    static var TAB_Home : String { get { "Home" }}
    static var TAB_2 : String { get { "2" }}
    static var TAB_3 : String { get { "3" }}
    static var TAB_4 : String { get { "4" }}
    static var TAB_Setting : String { get { "Settings" }}
    
    //MARK: - TITLES
    static var TITLE_Email : String { get { "Email" }}
    static var TITLE_Password : String { get { "Password" }}
    static var TITLE_Hit : String { get { "Hit Me!" }}
    static var TITLE_OK : String { get { "Ok" }}

    //MARK: - VC NAMES
    static var VC_Home : String { get { "HomeVC" }}
    
}
