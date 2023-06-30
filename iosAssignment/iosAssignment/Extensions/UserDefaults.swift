//
//  UserDefaults+Extensions.swift
//  Swing
//
//  Created by C110 on 22/11/17.
//  Copyright © 2017 C110. All rights reserved.
//

import UIKit
import Foundation

extension UserDefaults {
    func setCustom<T: Codable>(_ value: T?, forKey: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: forKey)
    }
    
    func setCustomArr<T: Codable>(_ value: [T], forKey: String) {
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: forKey)
    }
    
    func getCustom<T>(_ type: T.Type, forKey: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: forKey) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    func getCustomArr<T>(_ type: T.Type, forKey: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: forKey) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

