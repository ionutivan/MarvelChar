//
//  StoryType.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 17/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import Foundation

enum StoryType {
    case Comic
    case Story
    case Serie
}

extension StoryType: Equatable {}

func ==(rhs: StoryType, lhs: StoryType) -> Bool {
    switch rhs {
    case .Comic:
        switch lhs {
        case .Comic:
            return true
        default:
            return false
        }
    case .Story:
        switch lhs {
        case .Story:
            return true
        default:
            return false
        }
    case .Serie:
        switch lhs {
        case .Serie:
            return true
        default:
            return false
        }
    }
}