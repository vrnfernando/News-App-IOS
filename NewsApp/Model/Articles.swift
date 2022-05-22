//
//  Articles.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import Foundation
import UIKit
import ObjectMapper

class Article: NSObject, Mappable {
    
    var source         : Source!
    var author         : NSString = ""
    var title          : NSString = ""
    var _description   : NSString = ""
    var url            : NSString = ""
    var urlToImage     : NSString = ""
    var publishedAt    : NSString = ""
    var content        : NSString = ""
    
    
    internal init(source: Source, author: NSString, title: NSString, _description: NSString, url: NSString, urlToImage: NSString, publishedAt: NSString, content: NSString) {
        self.source      = source
        self.author      = author
        self.title       = title
        self._description = _description
        self.url         = url
        self.urlToImage  = urlToImage
        self.publishedAt = publishedAt
        self.content     = content
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        source          <- map["source"]
        author          <- map["author"]
        title           <- map["title"]
        _description    <- map["description"]
        url             <- map["url"]
        urlToImage      <- map["urlToImage"]
        publishedAt     <- map["publishedAt"]
        content         <- map["content"]
    }
    
    deinit {
        print("deinit - Article")
    }
}


