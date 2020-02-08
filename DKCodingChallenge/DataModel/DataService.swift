//
//  CSVService.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/3/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation

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
        
        print(CodingChallenge.shared.searchMultiContinuityWithinRange(data: swingData, indexBegin: 0, indexEnd: 1000, thresholdLo: 6, thresholdHi: 9, winLength: 10))
    }
    
    public func printDataSummary() {
        print("# of timestamps: " + String(swingData.count))
    }
    
    public func getSwingData() -> [Swing] {
        return swingData
    }
    

    
    
    
}
