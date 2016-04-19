//
//  Resource.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation
import Crypto

enum Method: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}

enum Constant: String {
    case baseURL = "http://gateway.marvel.com"
    enum Endpoint: String {
        case characters = "/v1/public/characters"
        case characterDetail = "/v1/public/characters/%d"
    }
    case apiPublicKey = "0dac58e8603e1a946fc868e4af83d17a"
    case apiPrivateKey = "9b085aedb6bc43560a546a594ae23ac6fd377212"
}

func ==(rhs: Constant.Endpoint, lhs: Constant.Endpoint) -> Bool {
    switch rhs {
    case .characters:
        switch lhs {
        case .characters:
            return true
        default:
            return false
        }
    case .characterDetail:
        switch lhs {
        case .characterDetail:
            return true
        default:
            return false
        }
    }
}

struct Error {
//    let reason: Reason
    let error: NSError?
}

struct Resource<A> {
    let path: String
    let method: Method
    let requestParameters: [String: AnyObject]?
    let headers: [String: String]?
    let parse: AnyObject -> A?
    
    init(path: String, method: Method, requestParameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, parse: AnyObject -> A?) {
        self.path = path
        self.method = method
        self.requestParameters = requestParameters
        self.headers = headers
        self.parse = parse
    }
    
    func configureRequest(path: String) -> NSURLRequest {
        let url = NSURL(string: Constant.baseURL.rawValue + path)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = self.method.rawValue
        if let headers = headers {
            for (key,value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        switch method {
        case .GET, .DELETE:
            if let requestParameters = requestParameters where requestParameters.count > 0 {
                var modifiedPath = path + "?"
                for (key, value) in requestParameters {
                    let stringValue = "\(value)"
                    modifiedPath = modifiedPath + "\(key)=\(stringValue.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!)&"
                }
                let url = NSURL(string: Constant.baseURL.rawValue + modifiedPath)!
                request.URL = url
                request.HTTPBody = nil
            }
        default:
            if let requestParameters = requestParameters where requestParameters.count > 0 {
                let jsonBody = requestParameters.count > 0 ? (try? NSJSONSerialization.dataWithJSONObject(requestParameters, options: NSJSONWritingOptions())) : nil
                request.HTTPBody = jsonBody
            } else {
                request.HTTPBody = nil
            }
        }
        
        return request
    }
    
    func loadAsynchronous(session: URLSessionProtocol = NSURLSession.sharedSession(), failure: ErrorType ->(), success: A-> ()) {
        let request = configureRequest(path)
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            
            
            if let httpResponse = response as? NSHTTPURLResponse
                where httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                let json = data.flatMap{
                    try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
                }
                if let result = json.flatMap(self.parse) {
                    success(result)
                } else {
                    failure(NetworkError.CouldNotParseJSON)
                }
                
            } else {
                failure(NetworkError.GeneralNetworkError)
            }
            
        }
        task.resume()
    }
}

enum NetworkError: ErrorType {
    case GeneralNetworkError
    case CouldNotParseJSON
}

func marvelHash(publicKey: String, timeStamp: Int, privateKey: String) -> String {
    let string = "\(timeStamp)"+privateKey+publicKey
    return string.MD5!
}