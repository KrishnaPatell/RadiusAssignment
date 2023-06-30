//
//  Constants.swift
//  UIDesign
//
//  Created by C100-174 on 29/05/23.
//

import Foundation
import UIKit


//MARK: - CHECK FOR DEVICE
let IS_IPAD = UI_USER_INTERFACE_IDIOM() != .phone

//MARK: - SCREEN BOUNDS
let SCREEN_WIDTH = UIScreen.main.bounds.size.width as CGFloat
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height as CGFloat
let SCREEN_SIZE = UIScreen.main.bounds.size
var HAS_TOP_NOTCH: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

//MARK: - SCREEN WIDTH FOR ORIGINAL FONTS
let SCREEN_WIDTH_FOR_ORIGINAL_FONT = IS_IPAD ? 768 : 414 as CGFloat
let SCREEN_HEIGHT_FOR_ORIGINAL_FONT = IS_IPAD ? 1024 : 896 as CGFloat

//MARK: - GET APPDELEGATE
let APP_DELEGATE = UIApplication.shared.delegate as? AppDelegate

//MARK: - SOME CONSTANT AND VARIABLE AND IN_LINE VARIABLE FUNCTIONS
let API_SUCCESS = true
let API_FAILED = false
var IS_NETWORK_CONNECTED = true
var TIME_ZONE = TimeZone.current.identifier
let APP_NAME = "Radius"
let USER_DEFAULTS = UserDefaults.standard
let kCHECK_INTERNET_CONNECTION = "Please check your internet connection"
let MESSAGE = "Something went wrog with server."
var IS_TESTDATA : Int {
    //return RequestManager.networkEnviroment == .dev ?  1 : 0
    return 1
}
var APP_LOGO_URL = ""/*URL(string: "\(RequestItemsType.BASEPATH.description)/Uploads/logo.png")*/

var APP_VERSION: String {
    return getVersion()
}


//MARK:- COMMON UTC DATE TIME
let CURRENT_UTC_Date = Date().toString(format: "yyyy-MM-dd")
let CURRENT_UTC_Date_Time = Date().localToUTC(format: "yyyy-MM-dd hh:mm")
var CURRENT_WEEK_DAY : String? {
    get {
        Date().toString(format: "EEEE")
    }
}


//MARK: - APP STORE
let APPSTORE_ID = ""
let APPSTORE_LINK = ""

//MARK: - ACCOUNT KEYS
var GOOGLE_KEY = ""
var GOOGLE_ID = ""

//MARK: - COUNTRY & CURRENCY
var COUNTRY_CODE = NSLocale.current.regionCode ?? ""
var CURRENCY_SYMBOL = ""

//MARK: - FONT NAMES
let fFONT_REGULAR_O   =   "HelveticaNeue"
let fFONT_BOLD_O      =   "HelveticaNeue-Bold"
//let fFONT_SEMIBOLD_O  =   "OpenSans-SemiBold"
let fFONT_MEDIUM_O    =   "HelveticaNeue-Medium"
let fFONT_ITALIC_O    =   "HelveticaNeue-Italic"
let fFONT_LIGHT_O     =   "HelveticaNeue-Light"

//MARK: - COLORS
//USE COLOR ASSET AND GIVE ITS NAME HERE.
let kCOLOR_THEME        = UIColor(named: "AccentColor")!
let kCOLOR_WHITE             = UIColor(named: "whiteColor")!
let kCOLOR_BLACK           = UIColor(named: "blackColor")!
let kCOLOR_GRADIENT = [kCOLOR_THEME.cgColor,  kCOLOR_BLACK.withAlphaComponent(0.0).cgColor]
let kCOLOR_GRADIENT_BUTTON = [kCOLOR_THEME.cgColor, UIColor(red: 31.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 0.5).cgColor]

//MARK:- STORYBOARD
let STORYBOARD_MAIN = UIStoryboard(name: "Main", bundle: nil)

//MARK:- PLACEHOLDER IMAGES


//MARK:- NOTIFICATION OBSERVER NAME
let NC_PROFILE_UPDATED = "ProfileUpdatedNotification"

//MARK:- TABs





