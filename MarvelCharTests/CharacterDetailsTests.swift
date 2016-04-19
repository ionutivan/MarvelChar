//
//  CharacterDetailsTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class CharacterDetailsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_shouldSetCharacterURL() {
        let characterURL = CharacterURL(type: "detail", url: "test")!
        let c = CharacterDetails(characterURLs: [characterURL], storyCollection: [])
        XCTAssertTrue(c.characterURLs.count == 1, "There should be one characterURL")
    }
    
    func testInit_shouldSetTales() {
        let characterTale = Story(type: .Comic, resourceURI: "test", name: "test name")
        let c = CharacterDetails(characterURLs: [], storyCollection: [characterTale])
        XCTAssertTrue(c.storyCollection.count == 1, "There should be one story in the collection")
    }
}
