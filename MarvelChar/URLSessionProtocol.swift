//
//  URLSessionProtocol.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

extension NSURLSession: URLSessionProtocol {}