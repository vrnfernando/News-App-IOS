//
//  HTTPResponse.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import Foundation
import UIKit

class HTTPResponse: NSObject {
    
    var responseStatus  : Bool  = true
    var responseResult  : JSON?
    var responseError   : RestClientError?
    
    init(status: Bool, result: JSON? = nil, error: RestClientError? = nil) {
        self.responseStatus     = status
        self.responseResult     = result
        self.responseError      = error
    }
    
    init(result: JSON? = nil, error: RestClientError? = nil) {
        self.responseResult     = result
        self.responseError      = error
    }
}
