//
//  HTTPService.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import Foundation
import Alamofire
import ObjectMapper


protocol DashBoardAPIDelegate: AnyObject {
    
    func getLatestNews(res: [Article])
    func getLatestNews(_ error: RestClientError)
    
    func getAllNews(res: [Article])
    func getAllNews(_ error: RestClientError)
    
}

protocol SearchAPIDelegate: AnyObject {
    
    func getSearchList(res: [Article])
    func getSearchList(_ error: RestClientError)
    
}

class HTTPService: NSObject {
    
    weak var dashBoardDelegate  : DashBoardAPIDelegate?
    weak var searchAPIDelegate  : SearchAPIDelegate?
    
    var baseUrl         : NSString?
    var parameters      : [String : AnyObject]?
    var headers         : HTTPHeaders
    var timeoutInterval : Double = 20
    var APIKey           : NSString?
    
    init(baseUrl: NSString! = "https://newsapi.org") {
        
        self.baseUrl    = baseUrl
        parameters      = [:]
        self.headers    = [
            "Content-Type":"application/json"]
        self.APIKey     = "031b189d80884f0fad69f7396ef1df6e"
    }
    
    //Get Requests
    func getRequest(_ parameters: [String: AnyObject]?, contextPath: NSString, completionHandler: @escaping (HTTPResponse) -> Void) {
        
        let urlString   = "\(self.baseUrl!)\(contextPath)\(self.APIKey!)" as URLConvertible
        
        print("urlString: ",urlString)
        print(self.headers)
        print(self.parameters)
        Alamofire.request(urlString, method: .get, parameters: self.parameters!, headers: self.headers).responseJSON { (response) in
            
            var httpResponse: HTTPResponse! = nil
            
            if let errorCode        = response.result.error,
               let errorMessage    = response.result.error?.localizedDescription {
                httpResponse                = HTTPResponse(result: nil, error: nil)
                print("alamofire error")
                print("getRequest -> error code: \(errorCode)")
                print("getRequest -> error message: \(errorMessage)")
                
            } else {
                
                do {
                    let jsonResult = try JSON(data: response.data!)
                    print("jsonResult:   \(jsonResult)")
                    if response.response!.statusCode >= 200 && response.response!.statusCode < 300 {    /// check
                        httpResponse        = HTTPResponse(result: jsonResult, error: nil)
                    } else if response.response!.statusCode == 401 {
                        // Error
                    }else{
                        let exception       = RestClientError.init(jsonResult: jsonResult)
                        httpResponse        = HTTPResponse(result: nil, error: exception)
                    }
                    
                } catch {
                    let exception           = RestClientError.jsonParseError(errorCode: "0" , errorMessage: "Error")
                    httpResponse            = HTTPResponse(result: nil, error: exception)
                }
            }
            if httpResponse != nil {
                completionHandler(httpResponse)
            }
        }
    }
}


extension HTTPService: LatestNewsProtocol {

    func getAllNews() {
        
        let contextPath = "/v2/everything?q=bitcoin&apiKey="
        
        getRequest(nil, contextPath: contextPath as NSString) { (response) in
            
            let responseError = response.responseError
            let responseResult  = response.responseResult
            
            if let error = responseError {
                self.dashBoardDelegate?.getAllNews(error)
                return
            }
            
            if let json = responseResult {
                if let jsonArray    = json["articles"].array {       //access requested data here
                    var articles       = [Article]()
                    for jsonObj in jsonArray {
                        if let jsonString   = jsonObj.rawString() {
                            if let article     = Mapper<Article>().map(JSONString: jsonString) {
                                articles.append(article)
                            }
                        }
                    }
                    
                    self.dashBoardDelegate?.getAllNews(res: articles)
//                    return
                } else {
                    let exception               = RestClientError.jsonParseError(errorCode: "0", errorMessage: "Error")
                    self.dashBoardDelegate?.getAllNews(exception)
                    return
                }
            }
            
            print("handle default error here: getModesDetails")
            return
        }
        
    }
    
    func getLatestNews() {
        
        let contextPath = "/v2/top-headlines?country=us&apiKey="
        
        getRequest(nil, contextPath: contextPath as NSString) { (response) in
            
            let responseError = response.responseError
            let responseResult  = response.responseResult
            
            if let error = responseError {
                self.dashBoardDelegate?.getLatestNews(error)
                return
            }
            
            if let json = responseResult {
                if let jsonArray    = json["articles"].array {       //access requested data here
                    var articles       = [Article]()
                    for jsonObj in jsonArray {
                        if let jsonString   = jsonObj.rawString() {
                            if let article     = Mapper<Article>().map(JSONString: jsonString) {
                                articles.append(article)
                            }
                        }
                    }
                    
                    self.dashBoardDelegate?.getLatestNews(res: articles)
//                    return
                } else {
                    let exception               = RestClientError.jsonParseError(errorCode: "0", errorMessage: "Error")
                    self.dashBoardDelegate?.getLatestNews(exception)
                    return
                }
            }
            
            print("handle default error here: getModesDetails")
            return
        }
        
        
        
    }
}


extension HTTPService: SearchNewsAPIProtocol{
    
    func getSearchNews() {
        
        let contextPath = "/v2/everything?q=Apple&from=2022-05-22&sortBy=popularity&apiKey="
        
        getRequest(nil, contextPath: contextPath as NSString) { (response) in
            
            let responseError = response.responseError
            let responseResult  = response.responseResult
            
            if let error = responseError {
                self.searchAPIDelegate?.getSearchList(error)
                return
            }
            
            if let json = responseResult {
                if let jsonArray    = json["articles"].array {       //access requested data here
                    var articles       = [Article]()
                    for jsonObj in jsonArray {
                        if let jsonString   = jsonObj.rawString() {
                            if let article     = Mapper<Article>().map(JSONString: jsonString) {
                                articles.append(article)
                            }
                        }
                    }
                    
                    self.searchAPIDelegate?.getSearchList(res: articles)
//                    return
                } else {
                    let exception               = RestClientError.jsonParseError(errorCode: "0", errorMessage: "Error")
                    self.searchAPIDelegate?.getSearchList(exception)
                    return
                }
            }
            
            print("handle default error here: getModesDetails")
            return
        }
    }
    
}
