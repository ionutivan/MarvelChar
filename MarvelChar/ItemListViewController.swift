//
//  ItemListViewController.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: ItemListDataProvider!
    let itemManager = ItemManager()
    let resultsController = SearchResultsTableViewController()
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController!.searchResultsUpdater = resultsController
        searchController!.dimsBackgroundDuringPresentation = true
        searchController!.hidesNavigationBarDuringPresentation = true
        searchController!.searchBar.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 44)
        tableView.tableHeaderView = searchController!.searchBar
        searchController!.searchBar.sizeToFit()
        definesPresentationContext = true
        dataProvider.delegate = self
        resultsController.itemManager = itemManager
        
        dataProvider.itemManager = itemManager
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        tableView.registerNib(UINib(nibName: "CharacterCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ItemCell")
        if itemManager.charactersCount <= 0 {
            let time = Int(NSDate().timeIntervalSince1970)
            let resource = Resource<PageItems<MarvelCharacter>>(path: Constant.Endpoint.characters.rawValue,
                                                                method: .GET,
                                                                requestParameters: ["apikey":Constant.apiPublicKey.rawValue, "ts": time, "hash":marvelHash(Constant.apiPublicKey.rawValue, timeStamp: time, privateKey:Constant.apiPrivateKey.rawValue)],
                                                                headers: ["Content-Type": "application/json"],
                                                                parse: PageItems.init)
            let failure: ErrorType -> () = { error in
                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                    let alert = UIAlertController(title: nil, message: "An error ocurred. Please try again later.", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(action)
                    self?.presentViewController(alert, animated: true, completion: nil)
                }
            }
            itemManager.getItemsForResource(resource, failure: failure){ pageItems in
                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension ItemListViewController: ItemListDataProviderProtocol {
    func openCharacterDetails(character: MarvelCharacter) {
        let detailVC = MarvelCharDetailViewController(marvelCharacter: character)
        presentViewController(detailVC, animated: true, completion: nil)
    }
}
