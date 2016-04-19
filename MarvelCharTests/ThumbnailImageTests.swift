//
//  ThumbnailImageTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class ThumbnailImageTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_shouldSetName() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        XCTAssertNotNil(t.name, "Name should not be nil")
    }
    
    func testInit_shouldSetNameAndExtension() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        XCTAssertNotNil(t.fileType, "FileType should not be nil")
    }

    func testInitWithDictionary_shouldInitWitDict() {
        let stringDictionary = "{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04\",\"extension\":\"jpg\"}"
        let data = stringDictionary.dataUsingEncoding(NSUTF8StringEncoding)
        let json = data.flatMap{
            try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
        }
        let ti = json.flatMap(ThumbnailImage.init)
        XCTAssertNotNil(ti, "The thumbnail image should not be nil")
    }
    
    func testInitWithDictionary_shouldSetTheName() {
        let stringDictionary = "{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04\",\"extension\":\"jpg\"}"
        let data = stringDictionary.dataUsingEncoding(NSUTF8StringEncoding)
        let json = data.flatMap{
            try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
        }
        let ti = json.flatMap(ThumbnailImage.init)
        XCTAssertEqual(ti?.name, "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", "The thumbnail name should be the same")
    }
}
