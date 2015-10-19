//
//  API.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private let _sharedInstace = AdobeAPI()

class AdobeAPI: NSObject {
    
    var baseURL = "http://104.196.26.10:4503"
    var mediaLink = ""
    var mediaType = ""
    let linkEndpoint = ".content.json"
    var finalURL = ""
    
    class func sharedInstance() -> AdobeAPI {
        return _sharedInstace
    }
    
    func loadMedia(completion: (([Media]) -> Void)!) {
        let urlEndpoint = "\(baseURL)/content/jabilpoc/en/kiosk-one.menu.json"
        let url = NSURL(string: urlEndpoint)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                do {
                    let json: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    if let dict = json as? [String: AnyObject] {
                        if let mediaDict = dict["menu"]! as? [AnyObject] {
                            
                            var mediaArray = [Media]()
                            for media in mediaDict {
                                let media = Media(data: media as! NSDictionary)
                                mediaArray.append(media)
                            }
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    completion(mediaArray)
                                })
                            }
                        }
                    }
                    
                } catch {
                    print("Somthing went wrong")
                }
            }
        }
        
        task.resume()
    }
    
    func getMediaLink(mediaLink: String, completionHandler: (NSArray?) -> Void){
        let urlString = "\(baseURL)\(mediaLink)\(linkEndpoint)"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    completionHandler(json)
                } catch {
                    print("Something went wrong again")
                }
            }
        }
        
        task.resume()
    }
    
    func returnImageArray(linkArray: NSArray, completionHandler: (NSArray?) -> Void) {
        
    }
}
