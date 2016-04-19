//
//  CharacterURL.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

enum CharacterURL {
    case Detail(url: String)
    case Wiki(url: String)
    case ComicLink(url: String)
    
    init?(type: String, url: String) {
        switch type {
        case "detail":
            self = .Detail(url: url)
        case "wiki":
            self = .Wiki(url: url)
        case "comiclink":
            self = .ComicLink(url: url)
        default:
            return nil
        }
    }
    
    init?(dict: AnyObject) {
        if let type = dict["type"] as? String,
            url = dict["url"] as? String {
            self.init(type: type, url: url)
        } else {
            return nil
        }
    }
}