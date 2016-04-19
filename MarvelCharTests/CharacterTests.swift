//
//  CharacterTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class CharacterTests: XCTestCase {
    
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
        let c = MarvelCharacter(id: 10, name: "Test name", summary: "", thumbnail: t)
        XCTAssertNotNil(c.name, "The name should not be nil")
    }
    
    func testInit_shouldSetNameAndId() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        let c = MarvelCharacter(id: 10, name: "Test name", summary: "", thumbnail: t)
        XCTAssertNotNil(c.id, "The id should not be nil")
        
    }
    
    func testInit_shouldSetNameAndIdAndThumbnail() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        let c = MarvelCharacter(id: 10, name: "Test name", summary: "", thumbnail: t)
        XCTAssertNotNil(c.thumbnail, "The thumbnail should not be nil")
    }
    
    func testInit_shouldSetNameAndIdAndThumbnailAndDetails() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        let details = CharacterDetails(characterURLs:[], storyCollection: [])
        let c = MarvelCharacter(id: 10, name: "Test name", summary: "", thumbnail: t, details: details)
        XCTAssertNotNil(c.details, "Details should not be nil")
    }
    
    func testWhenIdDiffers_ShouldNotBeEqual() {
        let t = ThumbnailImage(name: "testName", fileType: "testExtension")
        let c1 = MarvelCharacter(id: 1, name: "Test name", summary: "", thumbnail: t)
        let c2 = MarvelCharacter(id: 2, name: "Test name", summary: "", thumbnail: t)
        XCTAssertNotEqual(c1, c2, "The 2 marvel characters should not be equal")
    }
    
    func testInitWithDictionary_shouldInit() {
        let stringDictionary = "{\"id\":1009146,\"name\":\"Abomination (Emil Blonsky)\",\"description\":\"Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.\",\"modified\":\"2012-03-20T12:32:12-0400\",\"thumbnail\":{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04\",\"extension\":\"jpg\"}}"
        let data = stringDictionary.dataUsingEncoding(NSUTF8StringEncoding)
        let json = data.flatMap{
            try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
        }
        let c = json.flatMap(MarvelCharacter.init)
        XCTAssertNotNil(c, "The Marvel character should not be nil")
    }
    
    func testInitWithDictionary_shouldSetId() {
        let stringDictionary = "{\"id\":1009146,\"name\":\"Abomination (Emil Blonsky)\",\"description\":\"Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.\",\"modified\":\"2012-03-20T12:32:12-0400\",\"thumbnail\":{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04\",\"extension\":\"jpg\"}}"
        let data = stringDictionary.dataUsingEncoding(NSUTF8StringEncoding)
        let json = data.flatMap{
            try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
        }
        let c = json.flatMap(MarvelCharacter.init)
        XCTAssertEqual(c?.id, 1009146, "The ids should be equal")
    }
    
}
