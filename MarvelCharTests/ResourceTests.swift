//
//  ResourceTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class ResourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldSetPath() {
        let parse: AnyObject -> String = { data in return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: nil, parse: parse)
        XCTAssertEqual(r.path, Constant.Endpoint.characters.rawValue, "The path should setup")
    }
    
    func testInit_ShouldSetPathAndMethod() {
        let parse: AnyObject -> String = { data in return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: nil, parse: parse)
        XCTAssertEqual(r.method.rawValue, Method.GET.rawValue, "The method should be set up after init")
    }
    
    func testInit_ShouldSetPathAndMethodAndRequestParameters() {
        let rp: [String: AnyObject] = ["auth":"triple"]
        let parse: AnyObject -> String = { data in return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: rp, headers: nil, parse: parse)
        XCTAssertNotNil(r.requestParameters, "The requestParameters should be set after init")
    }
    
    func testInit_ShouldSetPathAndMethodAndRequestParametersAndHeaders() {
        let header = ["auth":"triple"]
        let parse: AnyObject -> String = { data in return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: header, parse: parse)
        XCTAssertNotNil(r.headers, "The headers should be set after init")
    }
    
    func testInit_ShouldSetPathAndMethodAndRequestParametersAndHeadersAndParse() {
        var response: Bool = false
        let parse: AnyObject -> String? = { data in
            response = true
            return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: nil, parse: parse)
        r.parse(NSData())
        XCTAssertEqual(response, true, "Parse method should not be nil")
    }
    
    func testConfigureRequest_shouldSetRequestPath() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        guard let path = request.URL?.path  else {
            fatalError()
        }
        XCTAssertEqual(path, r.path, "The path should be the same")
    }
    
    func testConfigureRequest_shouldSetMethod() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let method = Method.POST
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: method, requestParameters: nil, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        guard let reqMethod = request.HTTPMethod else {
            fatalError()
        }
        XCTAssertEqual(reqMethod, method.rawValue, "The method should be the same")
    }
    
    func testConfigureRequest_shouldSetHeaders() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let headerKey = "Content-Type"
        let headerValue = "application/json"
        let headers = [headerKey: headerValue]
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: nil, headers: headers, parse: parse)
        let request = r.configureRequest(r.path)
        guard let requestHeaderValue = request.valueForHTTPHeaderField(headerKey) else {
            fatalError()
        }
        XCTAssertEqual(requestHeaderValue, headerValue, "The header value should be the same as the one passed from resource")
    }
    
    func testConfigureRequest_shouldSetPathRequestParameters_IfMethodIsGet() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let requestParameters = ["id":"1"]
        let myQuery = "id=1&"
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: requestParameters, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        guard let query = request.URL?.query else {
            fatalError()
        }
        XCTAssertEqual(query, myQuery, "The query param should be the same")
    }
    
    func testConfigureRequest_shouldNotPathRequestParameters_IfMethodIsPost() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let requestParameters = ["id":"1"]
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .POST, requestParameters: requestParameters, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        let query = request.URL?.query
        XCTAssertNil(query, "The query should be nil")
    }
    
    func testConfigureRequest_shouldHaveNilHTTPBody_ifMethodIsGet() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let requestParameters = ["id":"1"]
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .GET, requestParameters: requestParameters, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        let body = request.HTTPBody
        XCTAssertNil(body, "The query should be nil")
    }
    
    func testConfigureRequest_shouldNotHaveNilHttpBody_ifMethodisPost() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let requestParameters = ["id":"1"]
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .POST, requestParameters: requestParameters, headers: nil, parse: parse)
        let request = r.configureRequest(r.path)
        let body = request.HTTPBody
        XCTAssertNotNil(body, "The query should not be nil")
    }
    
    func testLoadAsynchronous_callsResumeOfDataTask() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .POST, requestParameters: nil, headers: nil, parse: parse)
        let mockURLSession = MockURLSession()
        let failure:ErrorType? -> () = { e in }
        r.loadAsynchronous(mockURLSession, failure: failure){ item in }
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled, "The task should have been called")
    }
    
    func testLoadAsynchronous_NilDataCallsFailureBlock() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .POST, requestParameters: nil, headers: nil, parse: parse)
        let mockURLSession = MockURLSession()
        var error: ErrorType? = nil
        let failure:ErrorType? -> () = { e in error = e }
        r.loadAsynchronous(mockURLSession, failure: failure){ item in }
        mockURLSession.completionHandler?(nil, nil, nil)
        XCTAssertNotNil(error, "The error should not be nil")
    }
    
    func testLoadAsynchronous_GettingDataShouldNotCallFailureBlock() {
        let parse: AnyObject -> String? = { data in
            return "" }
        let r = Resource(path: Constant.Endpoint.characters.rawValue, method: .POST, requestParameters: nil, headers: nil, parse: parse)
        let mockURLSession = MockURLSession()
        var error: ErrorType? = nil
        let failure:ErrorType? -> () = { e in error = e }
        let responseDict = ["token" : "1234567890"]
        let responseData = try? NSJSONSerialization.dataWithJSONObject(responseDict,
            options: [])
        r.loadAsynchronous(mockURLSession, failure: failure){ item in }
        let response = NSHTTPURLResponse(URL: NSURL(string:"")!, statusCode: 200, HTTPVersion: nil, headerFields: nil)
        mockURLSession.completionHandler?(responseData, response, nil)
        XCTAssertNil(error, "The error should not be nil")
    }
    
}

class MockURLSession: URLSessionProtocol {
    typealias Handler = (NSData!, NSURLResponse!, NSError!) -> Void
    var completionHandler: Handler?
    var dataTask = MockURLSessionDataTask()
    
    func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        self.completionHandler = completionHandler
        return dataTask
    }
}

class MockURLSessionDataTask: NSURLSessionDataTask {
    var resumeGotCalled = false
    
    override func resume() {
        resumeGotCalled = true
    }
}


