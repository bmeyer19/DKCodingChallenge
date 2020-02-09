//
//  Operation.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

public enum Operation {
    case searchContinuityAboveValue
    case backSearchContinuityWithinRange
    case searchContinuityAboveValueTwoSignals
    case searchMultiContinuityWithinRange
    case none
    
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
            return "None"
        }
    }
    
    public func getText() -> String {
        switch self {
        case .searchContinuityAboveValue:
            return "From indexBegin to indexEnd, search data for values that are higher than threshold. Return the first index where data has values that meet this criteria for at least winLength samples in a row."
        case .backSearchContinuityWithinRange:
            return "From indexBegin to indexEnd (where indexBegin is larger than indexEnd), search data for values that are higher than thresholdLo and lower than thresholdHi. Return the first index where data has values that meet this criteria for at least winLength samples in a row."
        case .searchContinuityAboveValueTwoSignals:
            return "From indexBegin to indexEnd, search data1 for values that are higher than threshold1 and also search data2 for values that are higher than threshold2. Return the first index where both data1 and data2 have values that meet these criteria for at least winLength samples in a row."
        case .searchMultiContinuityWithinRange:
            return "From indexBegin to indexEnd, search data for values that are higher than thresholdLo and lower than thresholdHi. Return the the starting index and ending index of all continuous samples that meet this criteria for at least winLength data points."
        default:
            return "None"
        }
    }
    
}
