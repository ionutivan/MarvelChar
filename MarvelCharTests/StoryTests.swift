//
//  StoryTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class StoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_shouldSetType() {
        let s = Story(type: .Comic, resourceURI: "test", name: "test name")
        XCTAssertEqual(s.type, StoryType.Comic, "The type of the story should be true")
    }
    
    func testInit_shouldSetResourceURI() {
        let s = Story(type: .Comic, resourceURI: "test", name: "test name")
        XCTAssertEqual(s.resourceURI,"test", "The resourceURI should be equal to 'test'")
    }
    
    func testInit_shouldSetName() {
        let s = Story(type: .Comic, resourceURI: "test", name: "test name")
        XCTAssertEqual(s.name,"test name", "The name should be equal to 'test name'")
    }
    
    func test_WhenStoryTypeDiffers_StoriesShouldNotBeEqual() {
        let s1 = Story(type: .Comic, resourceURI: "test", name: "test name")
        let s2 = Story(type: .Story, resourceURI: "test", name: "test name")
        XCTAssertNotEqual(s1, s2, "Stories should not be the same")
    }

}
