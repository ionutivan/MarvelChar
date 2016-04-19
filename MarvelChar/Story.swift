//
//  Story.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

struct Story {
    let type: StoryType
    let resourceURI: String
    let name: String
}

extension Story: Equatable {}

func ==(rhs: Story, lhs: Story) -> Bool {
    return rhs.type == lhs.type && rhs.resourceURI == lhs.resourceURI && rhs.name == lhs.name
}