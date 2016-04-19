//
//  ItemManager.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

class ItemManager {
    var charactersCount: Int { return marvelCharacters.count }
    private var marvelCharacters = [MarvelCharacter]()
    var maximumNumberOfItems: Int?
    
    
    func addItem(character: MarvelCharacter) {
        if !marvelCharacters.contains(character) {
            marvelCharacters.append(character)
        }
    }
    
    func itemAtIndex(index: Int) -> MarvelCharacter {
        return marvelCharacters[index]
    }
    
    func removeAllItems() {
        marvelCharacters.removeAll()
    }
    
    func getItemsForResource(resource: Resource<PageItems<MarvelCharacter>>, failure: ErrorType->(), success:PageItems<MarvelCharacter> -> ()) {
        resource.loadAsynchronous(failure: failure) { [weak self] pageItems in
            self?.maximumNumberOfItems = pageItems.totalNumberOfItems
            self?.marvelCharacters.appendContentsOf(pageItems.items)
            success(pageItems)
        }
    }
    
    func allMarvelCharacters() -> [MarvelCharacter] {
        return marvelCharacters
    }
    
}

struct PageItems<A: DictionaryInitializable> {
    let items: [A]
    let offset: Int
    let totalNumberOfItems: Int
    
    init?(dict: AnyObject) {
        if let data = dict["data"] as? [String: AnyObject],
        results = data["results"] as? [AnyObject],
        total = data["total"] as? Int,
        offset = data["offset"] as? Int
        {
            self.totalNumberOfItems = total
            self.offset = offset
            items = results.flatMap(A.init)
        } else {
            return nil
        }
    }
}

protocol DictionaryInitializable {
    init?(dict: AnyObject)
}