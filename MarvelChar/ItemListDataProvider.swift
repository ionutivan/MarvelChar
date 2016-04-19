//
//  ItemListDataProvider.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation
import UIKit

protocol ItemListDataProviderProtocol: class {
    func openCharacterDetails(character: MarvelCharacter)
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    weak var delegate: ItemListDataProviderProtocol?
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return itemManager?.charactersCount ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! CharacterCell
        if let character = itemManager?.itemAtIndex(indexPath.row) {
            cell.data = CharacterCell.ViewData(character: character)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let itemManager = itemManager else {
            return
        }
        if indexPath.row == itemManager.charactersCount - 1 {
            let time = Int(NSDate().timeIntervalSince1970)
            let resource = Resource<PageItems<MarvelCharacter>>(path: Constant.Endpoint.characters.rawValue,
                                                                method: .GET,
                                                                requestParameters: ["apikey":Constant.apiPublicKey.rawValue,
                                                                    "ts": time,
                                                                    "hash":marvelHash(Constant.apiPublicKey.rawValue, timeStamp: time, privateKey:Constant.apiPrivateKey.rawValue),
                                                                    "offset":itemManager.charactersCount],
                                                                headers: ["Content-Type": "application/json"],
                                                                parse: PageItems.init)
            let failure: ErrorType -> () = { error in
                
            }
            itemManager.getItemsForResource(resource, failure: failure){ pageItems in
                dispatch_async(dispatch_get_main_queue()) {
                    tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let character = itemManager?.itemAtIndex(indexPath.row) {
            delegate?.openCharacterDetails(character)
        }
    }
}
