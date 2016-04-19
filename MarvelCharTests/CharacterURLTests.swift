//
//  CharacterURLTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class CharacterURLTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_shouldSetDetailURL() {
        let characterURL = CharacterURL.Detail(url: "test")
        let unpackedURL: String?
        if case .Detail(let url) = characterURL {
            unpackedURL = url
        } else {
            unpackedURL = nil
        }
        XCTAssertNotNil(unpackedURL, "The detail url should not be nil")
    }
    
    func testInit_shouldSetWikiURL() {
        let characterURL = CharacterURL.Wiki(url: "test")
        let unpackedURL: String?
        if case .Wiki(let url) = characterURL {
            unpackedURL = url
        } else {
            unpackedURL = nil
        }
        XCTAssertNotNil(unpackedURL, "The wiki url should not be nil")
    }
    
    func testInit_shouldSetComicLink() {
        let characterURL = CharacterURL.ComicLink(url: "test")
        let unpackedURL: String?
        if case .ComicLink(let url) = characterURL {
            unpackedURL = url
        } else {
            unpackedURL = nil
        }
        XCTAssertNotNil(unpackedURL, "The comic link url should not be nil")
    }
    
    func testInit_shouldInitWithTypeAndURLString() {
        let characterURL = CharacterURL.init(type: "detail", url: "test")
        XCTAssertNotNil(characterURL, "CharacterURL should not be nil")
    }

}
