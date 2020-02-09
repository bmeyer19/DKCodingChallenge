//
//  Column.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation

// Different features of the swing data
public enum Column {
    case ax
    case ay
    case az
    case wx
    case wy
    case wz
    
    public func getName() -> String {
        switch self {
        case .ax:
            return "ax"
        case .ay:
            return "ay"
        case .az:
            return "az"
        case .wx:
            return "wx"
        case .wy:
            return "wy"
        case .wz:
            return "wz"
        }
    }
}
