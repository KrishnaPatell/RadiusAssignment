//
//  BaseViewModel.swift
//  iosAssignment
//
//  Created by C100-174 on 12/30/21.
//  Copyright © 2021 C100-174. All rights reserved.

import UIKit

class BaseViewModel {
    
    // MARK: - Vars & Lets
    var isLoaderHidden: Dynamic<Bool> = Dynamic(true)
    var needToReload: Dynamic<Bool> = Dynamic(false)
    var successMessage: Dynamic<String> = Dynamic("")
    var warningTextMessage: Dynamic<String> = Dynamic("")
    
}
