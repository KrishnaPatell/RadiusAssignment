//
//  JSONExtension.swift
//  Bazinga
//
//  Created by C110 on 15/12/17.
//  Copyright © 2017 C110. All rights reserved.
//

//UNCOMMENT BELOW CODE AFTER INSTALLING PODS FOR IT
/*import Foundation
import SwiftyJSON
import Alamofire
import UIKit
extension JSON {
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(parameter: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else {
                let object = baseObj.init(parameter: self)
                return object!
            }
        }
        return nil
    }
}
protocol JSONable {
    init?(parameter: JSON)
}

extension JSONable {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}

func getJsonString(arrayDictionary:NSMutableArray) -> String {
    do{
        let jsonData : NSData = try JSONSerialization.data(withJSONObject: arrayDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        let json = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            return json as String
        }
    }
    catch{}
    return ""
}

func getJsonString(arrayDictionary:NSArray) -> String {
    do{
        let jsonData : NSData = try JSONSerialization.data(withJSONObject: arrayDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        let json = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            return json as String
        }
    }
    catch{}
    return ""
}
*/
