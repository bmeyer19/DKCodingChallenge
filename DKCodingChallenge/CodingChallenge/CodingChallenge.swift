//
//  CodingChallenge.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

class CodingChallenge {
    
    static let shared = CodingChallenge()
    
    // MARK: - CODING CHALLENGE OPERATIONS

    public func searchContinuityAboveValue(data: [Swing], indexBegin: Int, indexEnd: Int, threshold: Float, winLength: Int) -> Int? {
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsAboveThreshold = 0
        for index in Range(indexBegin...indexEnd) {
            var swingHasValueAboveThreshold = false
            let swing = data[index]
            for value in swing.getValues() {
                if value > threshold {
                    swingHasValueAboveThreshold = true

                }
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
    
    public func backSearchContinuityWithinRange(data: [Swing], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> Int? {
        var continuousSwingsWithinRange = 0
        for index in Range(indexEnd...indexBegin).reversed() {
            var swingHasValueWithinRange = false
            let swing = data[index]
            for value in swing.getValues() {
                if value > thresholdLo && value < thresholdHi {
                    swingHasValueWithinRange = true
                }
            }
            if swingHasValueWithinRange {
                continuousSwingsWithinRange += 1
                if continuousSwingsWithinRange >= winLength {
                    return index
                }
            } else {
                continuousSwingsWithinRange = 0
            }
        }
        return nil
    }
    
    public func searchContinuityAboveValueTwoSignals(data1: [Swing], data2: [Swing], indexBegin: Int, indexEnd: Int, threshold1: Float, threshold2: Float, winLength: Int) -> Int? {
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsAboveThreshold = 0
        for index in Range(indexBegin...indexEnd) {
            var swing1HasValueAboveThreshold1 = false
            var swing2HasValueAboveThreshold2 = false
            let swing1 = data1[index]
            let swing2 = data2[index]
            for value in swing1.getValues() {
                if value > threshold1 {
                    swing1HasValueAboveThreshold1 = true
                }
            }
            for value in swing2.getValues() {
                if value > threshold2 {
                    swing2HasValueAboveThreshold2 = true
                }
            }
            if swing1HasValueAboveThreshold1 && swing2HasValueAboveThreshold2 {
                if continuousSwingsAboveThreshold == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsAboveThreshold += 1
                if continuousSwingsAboveThreshold >= winLength {
                    return index
                }
            } else {
                continuousSwingsAboveThreshold = 0
            }
        }
        return nil
    }
    
    public func searchMultiContinuityWithinRange(data: [Swing], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> [(Int, Int)] {
        var continuousSwingsStartingIndices: [(Int,Int)] = []
        var continuousSwingsStartIndex = indexBegin
        var continuousSwingsWithinRange = 0
        for index in Range(indexBegin...indexEnd) {
            var swingHasValueWithinRange = false
            let swing = data[index]
            for value in swing.getValues() {
                if value > thresholdLo && value < thresholdHi {
                    swingHasValueWithinRange = true
                }
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
