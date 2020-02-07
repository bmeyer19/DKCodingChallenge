//
//  Operation.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

enum Operation {
    case searchContinuityAboveValue
    case backSearchContinuityWithinRange
    case searchContinuityAboveValueTwoSignals
    case searchMultiContinuityWithinRange
    
    public func getTitle() -> String {
        switch self {
        case .searchContinuityAboveValue:
            return "Search Continuity Above Value"
        case .backSearchContinuityWithinRange:
            return "Back Search Continuity Within Range"
        case .searchContinuityAboveValueTwoSignals:
            return "Search Continuity Above Value Two Signals"
        case .searchMultiContinuityWithinRange:
            return "Search Multi Continuity Within Range"
        default:
            return "Empty"
        }
    }
    
    public func getView() -> UIView {
        switch self {
        case .searchContinuityAboveValue:
            return UIView()
        case .backSearchContinuityWithinRange:
            return UIView()
        case .searchContinuityAboveValueTwoSignals:
            return UIView()
        case .searchMultiContinuityWithinRange:
            return UIView()
        default:
            return UIView()
        }
    }
}
