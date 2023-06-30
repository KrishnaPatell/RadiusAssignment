//
//  Enums.swift
//  UIDesign
//
//  Created by C100-174 on 29/05/23.
//

import Foundation


//MARK: - USER DEFAULT KEYS
enum DEFAULT_KEYS : String{
    case userDetails = "UserDetails"
    case isOnboardingCompleted = "OnboardCompleted"
}

//MARK: - WEEKDAYS
enum weekDay : String{
   case mo = "Mon"
   case tu = "Tue"
   case we = "Wed"
   case th = "Thu"
   case fr = "Fri"
   case sa = "Sat"
   case su = "Sun"
}

//MARK: - BANNER
enum BannerTitle : String {
    case validation = "Validation"
    case invalidCredentials = "Invalid Credentials"
    case underDevelopment = "Under Development"
    case registered = "Registered successfully."
    case noInternet = "Internet Connection Lost"
    case missingData = "Missing Parameter"
    case none = ""
}

