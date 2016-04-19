//
//  ItemManagerTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    override func setUp() {
        super.setUp()
        sut = ItemManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCharactersCount_initially_shouldBeZero() {
        XCTAssertEqual(sut.charactersCount, 0, "Initially characters count should be 0")
    }
    
    func testCharactersCount_AfterAddingOneItem_IsOne() {
        sut.addItem(MarvelCharacter(id:1, name: "test", summary: "", thumbnail: ThumbnailImage(name: "test name", fileType: "jpg")))
        XCTAssertEqual(sut.charactersCount, 1, "Number of Marvel characters should be 1")
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem() {
        let item = MarvelCharacter(id:1, name: "test", summary: "", thumbnail: ThumbnailImage(name: "test name", fileType: "jpg"))
        sut.addItem(item)
        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(item, returnedItem, "The items ids should be the same")
    }
    
    func testRemoveAllItems_ShouldResultInCountBeZero() {
        let item1 = MarvelCharacter(id:1, name: "test1", summary: "", thumbnail: ThumbnailImage(name: "test name1", fileType: "jpg"))
        let item2 = MarvelCharacter(id:2, name: "test2", summary: "", thumbnail: ThumbnailImage(name: "test name2", fileType: "jpg"))
        sut.addItem(item1)
        sut.addItem(item2)
        XCTAssertEqual(sut.charactersCount, 2, "The number of characters should be 2")
        sut.removeAllItems()
        XCTAssertEqual(sut.charactersCount, 0, "The number of characters should be 0")
    }
    
    func testAddingTheSameItem_DoesNotIncreaseCount() {
        let item1 = MarvelCharacter(id:1, name: "test1", summary: "", thumbnail: ThumbnailImage(name: "test name1", fileType: "jpg"))
        let item2 = MarvelCharacter(id:1, name: "test1", summary: "", thumbnail: ThumbnailImage(name: "test name1", fileType: "jpg"))
        sut.addItem(item1)
        sut.addItem(item2)
        XCTAssertEqual(sut.charactersCount, 1, "The number of characters should be 1")
    }
    
}
