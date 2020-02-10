//
//  CodingChallenge.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

// For csv reading to import the dataset, see DataModel > DataService.swift
class CodingChallenge {
    
    static let shared = CodingChallenge()
    
    // MARK: - CODING CHALLENGE OPERATIONS

    // Operation 1: searchContinuityAboveValue(data, indexBegin, indexEnd, threshold, winLength) - from indexBegin to indexEnd, search data for values that are higher than threshold. Return the first index where data has values that meet this criteria for at least winLength samples in a row.
    public func searchContinuityAboveValue(data: [Float], indexBegin: Int, indexEnd: Int, threshold: Float, winLength: Int) -> Int? {
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsAboveThreshold = 0
        for index in Range(indexBegin...indexEnd) {
            var swingHasValueAboveThreshold = false
            if data[index] > threshold {
                swingHasValueAboveThreshold = true
            }
            if swingHasValueAboveThreshold {
                if continuousSwingsAboveThreshold == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsAboveThreshold += 1
                if continuousSwingsAboveThreshold >= winLength {
                    return continuousSwingsStartIndex
                }
            } else {
                continuousSwingsAboveThreshold = 0
            }
        }
        return nil
    }
    
    // Operation 2: backSearchContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd (where indexBegin is larger than indexEnd), search data for values that are higher than thresholdLo and lower than thresholdHi. Return the first index where data has values that meet this criteria for at least winLength samples in a row.
    public func backSearchContinuityWithinRange(data: [Float], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> Int? {
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsWithinRange = 0
        for index in Range(indexEnd...indexBegin).reversed() {
            var swingHasValueWithinRange = false
            if data[index] > thresholdLo && data[index] < thresholdHi {
                swingHasValueWithinRange = true
            }
            if swingHasValueWithinRange {
                if continuousSwingsWithinRange == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsWithinRange += 1
                if continuousSwingsWithinRange >= winLength {
                    return continuousSwingsStartIndex
                }
            } else {
                continuousSwingsWithinRange = 0
            }
        }
        return nil
    }
    
    // Operation 3: searchContinuityAboveValueTwoSignals(data1, data2, indexBegin, indexEnd, threshold1, threshold2, winLength) - from indexBegin to indexEnd, search data1 for values that are higher than threshold1 and also search data2 for values that are higher than threshold2. Return the first index where both data1 and data2 have values that meet these criteria for at least winLength samples in a row.
    public func searchContinuityAboveValueTwoSignals(data1: [Float], data2: [Float], indexBegin: Int, indexEnd: Int, threshold1: Float, threshold2: Float, winLength: Int) -> Int? {
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsAboveThreshold = 0
        for index in Range(indexBegin...indexEnd) {
            var swingsHaveValueAboveThresholds = false
            if data1[index] > threshold1 && data2[index] > threshold2 {
                swingsHaveValueAboveThresholds = true
            }
            if swingsHaveValueAboveThresholds {
                if continuousSwingsAboveThreshold == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsAboveThreshold += 1
                if continuousSwingsAboveThreshold >= winLength {
                    return continuousSwingsStartIndex
                }
            } else {
                continuousSwingsAboveThreshold = 0
            }
        }
        return nil
    }
    
    // Operation 4: searchMultiContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd, search data for values that are higher than thresholdLo and lower than thresholdHi. Return the the starting index and ending index of all continuous samples that meet this criteria for at least winLength data points.
    public func searchMultiContinuityWithinRange(data: [Float], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> [(Int, Int)] {
        var continuousSwingsStartingIndices: [(Int,Int)] = []
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsWithinRange = 0
        for index in Range(indexBegin...indexEnd) {
            var swingHasValueWithinRange = false
            if data[index] > thresholdLo && data[index] < thresholdHi {
                swingHasValueWithinRange = true
            }
            if swingHasValueWithinRange {
                if continuousSwingsWithinRange == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsWithinRange += 1
                if continuousSwingsWithinRange >= winLength {
                    continuousSwingsStartingIndices.append((continuousSwingsStartIndex,index))
                }
            } else {
                continuousSwingsWithinRange = 0
            }
        }
        return continuousSwingsStartingIndices
    }
    
}
