//
//  Character.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

class MarvelCharacter {
    let id: Int
    let name: String
    let summary: String
    let thumbnail: ThumbnailImage
    var details: CharacterDetails?
    
    init(id: Int, name: String, summary: String, thumbnail: ThumbnailImage, details: CharacterDetails? = nil) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.details = details
        self.summary = summary
    }
    
    required init?(dict: AnyObject) {
        if let id = dict["id"] as? Int,
            name = dict["name"] as? String,
            summary = dict["description"] as? String,
        thumbnail = dict["thumbnail"].flatMap(ThumbnailImage.init)
        {
            self.id = id
            self.name = name
            self.thumbnail = thumbnail
            self.summary = summary
            self.details = nil
        } else {
            return nil
        }
    }
    
    func addDetails(dict: AnyObject) -> MarvelCharacter? {
        if let data = dict["data"] as? [String: AnyObject],
            results = data["results"] as? [AnyObject],
        characterDict = results.first,
        urls = characterDict["urls"] as? [AnyObject]
        {
            let urlArray = urls.flatMap(CharacterURL.init)
            let details = CharacterDetails(characterURLs: urlArray, storyCollection: [])
            self.details = details
            return self
        } else {
            return nil
        }
    }
}

extension MarvelCharacter: Equatable {}
extension MarvelCharacter: DictionaryInitializable {}

func ==(lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
    return lhs.id == rhs.id
}