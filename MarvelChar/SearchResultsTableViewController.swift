//
//  SearchResultsTableViewController.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    var bgOperationQueue = NSOperationQueue()
    let reuseIdentifier = "cellIdentifier"
    var itemManager: ItemManager?
    var fullList = [MarvelCharacter]() {
        didSet {
            filteredList = fullList
        }
    }
    var filteredList = [MarvelCharacter]() {
        didSet {
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        bgOperationQueue.name = "background queue"
        guard let itemManager = itemManager else {
            return
        }
        fullList = itemManager.allMarvelCharacters()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CharacterCell
        cell.data = CharacterCell.ViewData(character: filteredList[indexPath.row])
        return cell
    }
    
}

extension SearchResultsTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if !searchController.active {
            return
        }
        if let text = searchController.searchBar.text {
            
            let operation = NSBlockOperation{ [weak self] in
                if let ws = self {
                    ws.filteredList = ws.fullList.filter{ $0.name.lowercaseString.containsString(text.lowercaseString)}
                }
            }
            
            if bgOperationQueue.operationCount > 0 {
                bgOperationQueue.cancelAllOperations()
            }
            
            bgOperationQueue.addOperation(operation)
        }
    }
}
