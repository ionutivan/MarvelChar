//
//  ItemListDataProviderTests.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import XCTest
@testable import MarvelChar

class ItemListDataProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections_is1() {
        let sut = ItemListDataProvider()
        let tableView = UITableView()
        tableView.dataSource = sut
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfRows_inSection_isEqualToItemsManagerCount() {
        let sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        let tableView = UITableView()
        tableView.dataSource = sut
        sut.itemManager?.addItem(MarvelCharacter(id: 1, name: "AntMan", summary: "", thumbnail: ThumbnailImage(name: "name", fileType: "jpg")))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 1)

    }
    
    func testCellForRow_ReturnsCharacterCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemListVC = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = itemListVC.view
        itemListVC.dataProvider.itemManager?.addItem(MarvelCharacter(id: 1, name: "AntMan", summary: "", thumbnail: ThumbnailImage(name: "name", fileType: "jpg")))
        itemListVC.tableView.reloadData()
        let cell = itemListVC.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0,
            inSection: 0))
        XCTAssertTrue(cell is CharacterCell)
    }
    
}
