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
    
    // MARK: - Functions
    
    public func read(_ filename : String){
        let path = Bundle.main.path(forResource: filename, ofType: "csv")!
        let url = URL(fileURLWithPath: path)
        let urlContents = try! String(contentsOf: url)
        let rows = urlContents.split(separator: "\r\n")
        for row in rows {
            let swing = row.split(separator: ",")
            print(swing)
        }
    }

}
