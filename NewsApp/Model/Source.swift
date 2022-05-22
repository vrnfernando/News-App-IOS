//
//  Source.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import Foundation
import UIKit
import ObjectMapper

class Source: NSObject, Mappable {
    
    var id       : NSString = ""
    var name     : NSString = ""
    
    internal init(id: NSString, name: NSString) {
        self.id      = id
        self.name    = name
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
    }
    
    deinit {
        print("deinit - Article")
    }
}
