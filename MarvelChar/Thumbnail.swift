//
//  Thumbnail.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

struct ThumbnailImage {
    let name: String
    let fileType: String
    
    init(name: String, fileType: String) {
        self.name = name
        self.fileType = fileType
    }
    
    init?(dict: AnyObject) {
        if let path = dict["path"] as? String,
            fileType = dict["extension"] as? String {
            name = path
            self.fileType = fileType
        } else {
            return nil
        }
    }
}

extension ThumbnailImage: CustomStringConvertible {
    var description: String {
        return name+"."+fileType
    }
}