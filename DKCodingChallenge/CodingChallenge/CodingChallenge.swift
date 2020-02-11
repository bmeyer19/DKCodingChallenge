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
    public func searchContinuityAboveValue(data: NSArray, indexBegin: Int, indexEnd: Int, threshold: Float, winLength: Int) -> Int? {
        let predicate = NSPredicate(format: "floatValue > %@", argumentArray: [threshold])
        //let predicate2 = NSPredicate(format: "floatValue < %@", argumentArray: [1])
        let indices = continuityHelper(dataPair: [(data, predicate)], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength)
        print(indices)
        return indices.first?.0
    }
    // Operation 2: backSearchContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd (where indexBegin is larger than indexEnd), search data for values that are higher than thresholdLo and lower than thresholdHi. Return the first index where data has values that meet this criteria for at least winLength samples in a row.
    public func backSearchContinuityWithinRange(data: NSArray, indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> Int? {
        let predicateLo = NSPredicate(format: "floatValue > %@", argumentArray: [thresholdLo])
        let predicateHi = NSPredicate(format: "floatValue > %@", argumentArray: [thresholdHi])
        let predicates = [predicateLo, predicateHi]
        let compoundPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        let indices = continuityHelper(dataPair: [(data, compoundPredicate)], indexBegin: indexEnd, indexEnd: indexBegin, winLength: winLength)
        print(indices)
        return indices.last?.1
    }
    
    // Operation 3: searchContinuityAboveValueTwoSignals(data1, data2, indexBegin, indexEnd, threshold1, threshold2, winLength) - from indexBegin to indexEnd, search data1 for values that are higher than threshold1 and also search data2 for values that are higher than threshold2. Return the first index where both data1 and data2 have values that meet these criteria for at least winLength samples in a row.
    public func searchContinuityAboveValueTwoSignals(data1: NSArray, data2: NSArray, indexBegin: Int, indexEnd: Int, threshold1: Float, threshold2: Float, winLength: Int) -> Int? {
        let predicate1 = NSPredicate(format: "floatValue > %@", argumentArray: [threshold1])
        let predicate2 = NSPredicate(format: "floatValue > %@", argumentArray: [threshold2])
        let indices = continuityHelper(dataPair: [(data1, predicate1),(data2, predicate2)], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength)
        print(indices)
        return indices.first?.0
    }
    
    // Operation 4: searchMultiContinuityWithinRange(data, indexBegin, indexEnd, thresholdLo, thresholdHi, winLength) - from indexBegin to indexEnd, search data for values that are higher than thresholdLo and lower than thresholdHi. Return the the starting index and ending index of all continuous samples that meet this criteria for at least winLength data points.
    public func searchMultiContinuityWithinRange(data: NSArray, indexBegin: Int, indexEnd: Int, thresholdLo: Float, thresholdHi: Float, winLength: Int) -> [(Int, Int)] {
        let predicateLo = NSPredicate(format: "floatValue > %@", argumentArray: [thresholdLo])
        let predicateHi = NSPredicate(format: "floatValue > %@", argumentArray: [thresholdHi])
        let predicates = [predicateLo, predicateHi]
        let compoundPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        let indices = continuityHelper(dataPair: [(data, compoundPredicate)], indexBegin: indexBegin, indexEnd: indexEnd, winLength: winLength)
        return indices
    }
    
    // Helper function that takes in a list of data-predicate pairs and finds all sequences of at least a certain length within a given range
    private func continuityHelper(dataPair: [(NSArray,NSPredicate)], indexBegin: Int, indexEnd: Int, winLength: Int) -> [(Int,Int)] {
        var filteredData: [NSArray] = []
        for pair in dataPair {
            let filteredDataset = NSArray(array: pair.0.filtered(using: pair.1))
            filteredData.append(filteredDataset)
        }
        var continuousSwingsIndices: [(Int,Int)] = []
        var continuousSwingsStartIndex = 0
        var continuousSwingsSatisfyingPredicate = 0
        for index in Range(indexBegin...indexEnd) {
            var allPredicatesSatisfied = true
            for (datasetIndex, pair) in dataPair.enumerated() {
                allPredicatesSatisfied = filteredData[datasetIndex].contains(pair.0[index]) && allPredicatesSatisfied
            }
            if allPredicatesSatisfied {
                if continuousSwingsSatisfyingPredicate == 0 {
                    continuousSwingsStartIndex = index
                }
                continuousSwingsSatisfyingPredicate += 1
            } else {
                if continuousSwingsSatisfyingPredicate >= winLength {
                    continuousSwingsIndices.append((continuousSwingsStartIndex,index))
                }
                continuousSwingsSatisfyingPredicate = 0
            }
        }
        
        return continuousSwingsIndices
    }
    
    
    
    
    
    
}
