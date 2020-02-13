//
//  CodingChallenge.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation


// For csv reading to import the dataset, see DataModel > DataService.swift
class CodingChallenge {
    
    static let shared = CodingChallenge()
    
    // MARK: - CODING CHALLENGE OPERATIONS

    // Operation 1: searchContinuityAboveValue(data, indexBegin, indexEnd, threshold, winLength) - from indexBegin to indexEnd, search data for values that are higher than threshold. Return the first index where data has values that meet this criteria for at least winLength samples in a row.
    public func searchContinuityAboveValue(data: [Float], indexBegin: Int, indexEnd: Int, threshold: Float, winLength: Int) -> Int? {
        return continuityHelper(data: [(data, .aboveThreshold(threshold))], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength).first?.0
    }
    // Operation 2: backSearchContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd (where indexBegin is larger than indexEnd), search data for values that are higher than thresholdLo and lower than thresholdHi. Return the first index where data has values that meet this criteria for at least winLength samples in a row.
    public func backSearchContinuityWithinRange(data: [Float], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> Int? {
        return continuityHelper(data: [(data, .withinRange(from: thresholdLo, to: thresholdHi))], indexBegin: indexEnd, indexEnd: indexBegin, winLength: winLength).last?.1
    }
    
    // Operation 3: searchContinuityAboveValueTwoSignals(data1, data2, indexBegin, indexEnd, threshold1, threshold2, winLength) - from indexBegin to indexEnd, search data1 for values that are higher than threshold1 and also search data2 for values that are higher than threshold2. Return the first index where both data1 and data2 have values that meet these criteria for at least winLength samples in a row.
    public func searchContinuityAboveValueTwoSignals(data1: [Float], data2: [Float], indexBegin: Int, indexEnd: Int, threshold1: Float, threshold2: Float, winLength: Int) -> Int? {
        return continuityHelper(data: [(data1, .aboveThreshold(threshold1)),(data2, .aboveThreshold(threshold2))], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength).first?.0
    }
    
    // Operation 4: searchMultiContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd, search data for values that are higher than thresholdLo and lower than thresholdHi. Return the the starting index and ending index of all continuous samples that meet this criteria for at least winLength data points.
    public func searchMultiContinuityWithinRange(data: [Float], indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> [(Int, Int)] {
        return continuityHelper(data: [(data, .withinRange(from: thresholdLo, to: thresholdHi))], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength)
    }
    
    // Helper function that takes in a list of data-predicate pairs and finds all sequences of at least a certain length within a given range. At each index, it checks all datasets with their respective predicates. As we check, we keep track of how long the sequence has been. If a value fails and the continuity before it is more than winLength values, we add the start and end indices to an array.
    private func continuityHelper(data: [([Float],Predicate<Float>)], indexBegin: Int, indexEnd: Int, winLength: Int) -> [(Int,Int)] {
        var continuousSwingsIndices: [(Int,Int)] = []
        var continuousSwingsStartIndex = indexBegin
        for index in Range(indexBegin...indexEnd) {
            for (dataset, predicate) in data {
                let isLastIndex = index == indexEnd
                let valueSatisfiesPredicate = [dataset[index]].contains(where: predicate.matches)
                if !valueSatisfiesPredicate || isLastIndex {
                    if index - continuousSwingsStartIndex + (isLastIndex && valueSatisfiesPredicate ? 1 : 0) >= winLength {
                        continuousSwingsIndices.append((continuousSwingsStartIndex,index - (isLastIndex ? 0 : 1)))
                    }
                    continuousSwingsStartIndex = index + 1
                    continue
                }
            }
        }
        return continuousSwingsIndices
    }
    
}

struct Predicate<Target> {
    var matches: (Target) -> Bool
    
    init(matcher: @escaping (Target) -> Bool) {
        matches = matcher
    }
}

extension Predicate where Target == Float {
    static func aboveThreshold(_ threshold: Float) -> Self {
        Predicate {
            $0.self > threshold
        }
    }
    
    static func withinRange(from thresholdLo: Float, to thresholdHi: Float) -> Self {
        Predicate {
            $0.self > thresholdLo && $0.self < thresholdHi
        }
    }
}

func ==<T, V: Equatable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    Predicate { $0[keyPath: lhs] == rhs }
}

prefix func !<T>(rhs: KeyPath<T, Bool>) -> Predicate<T> {
    rhs == false
}

func ><T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    Predicate { $0[keyPath: lhs] > rhs }
}

func <<T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    Predicate { $0[keyPath: lhs] < rhs }
}

func &&<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { lhs.matches($0) && rhs.matches($0) }
}

func ||<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { lhs.matches($0) || rhs.matches($0) }
}

func ~=<T, V: Collection>(lhs: KeyPath<T, V>, rhs: V.Element) -> Predicate<T> where V.Element: Equatable {
    Predicate { $0[keyPath: lhs].contains(rhs) }
}

