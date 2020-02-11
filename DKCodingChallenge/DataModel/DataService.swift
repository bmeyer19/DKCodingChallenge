//
//  CSVService.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/3/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation

// Shared workspace for retrieving data
public class DataService {
    
    static let shared = DataService()
    
    private var swingData : [Swing] = []
    
    // MARK: - Functions
    
    public func readCSV(_ filename: String){
        let path = Bundle.main.path(forResource: filename, ofType: "csv")!
        let url = URL(fileURLWithPath: path)
        let urlContents = try! String(contentsOf: url)
        let rows = urlContents.split(separator: "\r\n")
        for row in rows {
            let swingArray = row.split(separator: ",")
            let swing = Swing(swingArray: swingArray)
            swingData.append(swing)
        }
    }
    
    public func getSwingData() -> [Swing] {
        return swingData
    }
    
    public func getColumn(column: Column) -> NSArray {
        var data: [NSNumber] = []
        for swing in swingData {
            let value = swing.getColumn(column: column)
            data.append(value)
        }
        return data as NSArray
    }
    
    // get a string description of an operation with given parameters
    public func testOperation(operation: Operation, data: NSArray, data2: NSArray, indexBegin: Int, indexEnd: Int, threshold1: Float, threshold2: Float, winLength: Int) -> String {
        switch operation {
        case .searchContinuityAboveValue:
            let result = CodingChallenge.shared.searchContinuityAboveValue(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                threshold: threshold1,
                winLength: winLength)
            if let output = result {
                return String(output)
            } else {
                return "No Continuity Found"
            }
        case .backSearchContinuityWithinRange:
            let result = CodingChallenge.shared.backSearchContinuityWithinRange(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                thresholdLo: threshold1,
                thresholdHi: threshold2,
                winLength: winLength)
            if let output = result {
                return String(output)
            } else {
                return "No Continuity Found"
            }
        case .searchContinuityAboveValueTwoSignals:
            let result = CodingChallenge.shared.searchContinuityAboveValueTwoSignals(
                data1: data,
                data2: data2,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                threshold1: threshold1,
                threshold2: threshold2,
                winLength: winLength)
            if let output = result {
                return String(output)
            } else {
                return "No Continuity Found"
            }
        case .searchMultiContinuityWithinRange:
            let result = CodingChallenge.shared.searchMultiContinuityWithinRange(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                thresholdLo: threshold1,
                thresholdHi: threshold2,
                winLength: winLength)
            return result.description
        }
       
        
    }
    
}
