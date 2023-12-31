//
//  APIHelper.swift
//  ImageFetchingAndDisplayingDemo
//
//  Created by Jagjeetsingh Labana on 25/12/20.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
@available(iOS 13.0, *)
class APIHelper {
    static let shared : APIHelper = {
        let instance = APIHelper()
        return instance
    }()
    
    //MARK: - Get Request to be called
    func postJsonRequest(url:String,parameter: Parameters,headers: HTTPHeaders,completion: @escaping (Bool,String,[String:Any]) -> Void) {
        if !IS_NETWORK_CONNECTED
        {
            BASEVIEW_CONTROLLER?.showBanner(message: "Please check your internet connection..", type: .warning)
            completion(false, "ConnectionLost", [:])
        }
        //WriteLogsInFile(text: "\nURL : \(url)")
        print("\nURL : ",url)
        //WriteLogsInFile(text: "\nParameters : \(parameter)")
        print("\nParam : ",parameter)
        Alamofire.request(url,
                          method: .post,
                          parameters: parameter,
                          encoding: JSONEncoding.default,
                          headers: headers ).validate(contentType: ["application/json"]).responseJSON
            { (response:DataResponse<Any>) in
                            if let data = response.data
                            { let json = String(data: data, encoding: String.Encoding.utf8)
                                print("URL : ",url)
                                print("Response: \(String(describing: json))")
//                                WriteLogsInFile(text: "\nResponse : \(String(describing: json))")
                                
                            }
                //print("RESPONSE : - ",response)
                if let _ = response.result.error{
                    if((response.result.error! as NSError).code == NSURLErrorNetworkConnectionLost || (response.result.error! as NSError).code == NSURLErrorTimedOut){
                        self.postJsonRequest(url: url, parameter: parameter, headers: headers, completion: completion)
                    }else{
                         completion(false, MESSAGE,[:])
                       // responseData(nil, response.result.error as NSError?, MESSAGE)
                    }
                }
                
                let status = response.response?.statusCode
                print("STATUS \(status ?? 0)")
                if let data = response.data
                {
                    _ = String(data: data, encoding: String.Encoding.utf8)
                   // print("Response: \(String(describing: json))")

                }
                switch(response.result)
                {
                case .success( _):
                    if let result = response.result.value as? [String:Any]{
                        completion(true, "success", result)
                    }else{
                        completion(false, "Failed", [:])
                    }
                  //  print("response is success:  \(response)")
                    break
                case .failure( _):
                    
                    
                    var message = "Something went wrong"
                    guard case let .failure(error) = response.result else { return }
                    
                        if let error = error as? AFError {
                            switch error {
                            case .invalidURL(let url):
                                print("Invalid URL: \(url) - \(error.localizedDescription)")
                                message = "Invalid URL"
                            case .parameterEncodingFailed(let reason):
                                print("Parameter encoding failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                                message = "Parameter encoding failed"
                            case .multipartEncodingFailed(let reason):
                                print("Multipart encoding failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                                message = "Multipart encoding failed"
                            case .responseValidationFailed(let reason):
                                print("Response validation failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                                message = "Response validation failed"
                            case .responseSerializationFailed(let reason):
                                print("Response serialization failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                                message = "Response serialization failed"
                            }
                            
                            print("Underlying error: \(error.underlyingError ?? "")")
                        } else if let error = error as? URLError {
                            print("URLError occurred: \(error)")
                        } else {
                            print("Unknown error: \(error)")
                        }
                    completion(false, message,[:])
                    break
                }
        }
    }
    
    func postMultipartJSONRequest(url:String, parameters:Parameters, encodingType:ParameterEncoding = JSONEncoding.default,headers: HTTPHeaders, completion:@escaping (Bool,String,[String:Any]) -> Void)
    {
        //ShowNetworkIndicator(xx: true)
        if !IS_NETWORK_CONNECTED
        {
            BASEVIEW_CONTROLLER?.showBanner(bannerTitle: .none, message: "Please check your internet connection..", type: .warning)
            completion(false, "ConnectionLost", [:])
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var imageCount = 1
            for (key, value) in parameters
            {
                if value is UIImage {
                    if let imageData:Data = (value as? UIImage)?.jpegData(compressionQuality: 0.3)
                    {
                        multipartFormData.append(imageData, withName: key , fileName: "swift_file_\(imageCount).jpg", mimeType: "image/*")
                        imageCount += 1
                    }
                }
                else if value is NSArray || value is NSMutableArray {
                    for childValue in value as! NSArray
                    {
                        if childValue is UIImage {
                            if let imageData:Data = (childValue as? UIImage)?.jpegData(compressionQuality: 0.3)
                            {
                                multipartFormData.append(imageData, withName: key , fileName: "swift_file_\(imageCount).jpg", mimeType: "image/*")
                                imageCount += 1
                            }
                        }
                    }
                }else if value is [UIImage] {
                    for childValue in value as! [UIImage]
                    {
                        let imageData:Data = (childValue).jpegData(compressionQuality: 0.3)!
                        multipartFormData.append(imageData, withName: key , fileName: "swift_file_\(imageCount).jpg", mimeType: "image/*")
                        imageCount += 1
                    }
                }
                else if value is URL{
                    let audioData : Data
                    do {
                        audioData = try Data (contentsOf: (value as! URL), options: .mappedIfSafe)
                        multipartFormData.append(audioData, withName: key , fileName: "swift_file.m4a", mimeType: "audio/*")
                    } catch {
                        print(error)
                        return
                    }
                }else if value is NSURL || value is URL {
                    let videoData:Data
                    do {
                        videoData = try Data (contentsOf: (value as! URL), options: .mappedIfSafe)
                        multipartFormData.append(videoData, withName: key , fileName: "swift_file.mp4", mimeType: "video/*")
                    } catch {
                        print(error)
                        return
                    }
                }
                else if let otherValue = "\(value)".data(using: .utf8) {
                    multipartFormData.append(otherValue, withName: key )
                }
            }
            
        }, to: url, headers: headers) { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //if isUploading && isForeground {
                    //self.delegate?.didReceivedProgress(progress: Float(progress.fractionCompleted))
                    //}
                })
                
                upload.responseString(completionHandler: { (resp) in
                    //print("RESP : \(resp)")
                })
                
                upload.responseJSON { response in
                    print(response)
                    if let data = response.data
                    {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Response: \(String(describing: json))")
                        
                    }
                    switch(response.result) {
                    case .success(_):
                        if let result = response.result.value as? [String:Any]{
                            completion(true, "success", result)
                        }else{
                            completion(false, "Failed", [:])
                        }
                        break
                        
                    case .failure(_):
                        var message = "Something went wrong"
                        guard case let .failure(error) = response.result else { return }
                        
                            if let error = error as? AFError {
                                switch error {
                                case .invalidURL(let url):
                                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                                    message = "Invalid URL"
                                case .parameterEncodingFailed(let reason):
                                    print("Parameter encoding failed: \(error.localizedDescription)")
                                    print("Failure Reason: \(reason)")
                                    message = "Parameter encoding failed"
                                case .multipartEncodingFailed(let reason):
                                    print("Multipart encoding failed: \(error.localizedDescription)")
                                    print("Failure Reason: \(reason)")
                                    message = "Multipart encoding failed"
                                case .responseValidationFailed(let reason):
                                    print("Response validation failed: \(error.localizedDescription)")
                                    print("Failure Reason: \(reason)")
                                    message = "Response validation failed"
                                case .responseSerializationFailed(let reason):
                                    print("Response serialization failed: \(error.localizedDescription)")
                                    print("Failure Reason: \(reason)")
                                    message = "Response serialization failed"
                                }
                                
                                print("Underlying error: \(error.underlyingError ?? "")")
                            } else if let error = error as? URLError {
                                print("URLError occurred: \(error)")
                            } else {
                                print("Unknown error: \(error)")
                            }
                        completion(false, message,[:])
                        break
                        
                    }
                }
            case .failure( _):
                completion(false, "Something went wrong",[:])
            }
        }
    }
    
    //MARK:- GET Request
    func getRequestWithoutParams(endpointurl:String,responseData:@escaping (_ data:AnyObject?, _ error: NSError?, _ message: String?) -> Void)
    {
        
        let  alamofireManager = Alamofire.SessionManager.default
        alamofireManager.request(endpointurl, method: .get).responseJSON { (response:DataResponse<Any>) in
            
//                        if let data = response.data
//                        { let json = String(data: data, encoding: String.Encoding.utf8)
//                            print("Response: \(String(describing: json))")
//
//                        }
            
            if let _ = response.result.error
            {
                responseData(nil, response.result.error as NSError?,MESSAGE)
            }
            else
            {
                switch(response.result)
                {
                case .success(_):
                    if let data = response.result.value
                    {
                        //let Message = (data as! NSDictionary)[MESSAGE] as! String
//                        let responseStatus = (data as! NSDictionary)[VSTATUS] as! NSString
//                        // if ( responseStatus .isEqual(to: RESPONSE_STATUS_message.success.rawValue as String))
//                        if ( responseStatus .isEqual(to:"success"))
//                        {
//                            self.resObjects = (data as! NSDictionary) as AnyObject!
//                        }
//                        else
//                        {
//                            self.resObjects = (data as! NSDictionary) as AnyObject!
//                        }
//
                        responseData(data as AnyObject, nil, "Sucess")
                    }
                    break
                case .failure(_):
                    responseData(nil, response.result.error as NSError?, MESSAGE)
                    break
                }
            }
        }
    }

}
