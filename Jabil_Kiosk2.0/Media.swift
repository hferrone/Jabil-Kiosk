//
//  Media.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/6/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import Foundation

class Media {
    var menuItemText: String!
    var menuItemLink: String!
    var mediaType: String!
    
    init(data: NSDictionary) {
        self.menuItemText = data["menuItemText"] as! String
        self.menuItemLink = data["menuItemLink"] as! String
        self.mediaType = data["mediaType"] as! String
    }
    
    func checkOptionalStringsInJSON(data: NSDictionary, key: String) -> String {
        if let info = data[key] as? String {
            return info
        }
        
        return ""
    }
}
