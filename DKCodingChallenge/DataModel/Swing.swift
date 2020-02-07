//
//  Swing.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/3/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation

public struct Swing {
    
    // MARK: - Variables
    
    private var timestamp : Int!
    private var values : [Float]!
    
    // MARK: - Initializer
    
    public init(swingArray : [Substring.SubSequence]) {
        timestamp = Int(swingArray[0])
        values = []
        for index in Range(1...6) {
            let value = Float(swingArray[index]) ?? 0
            values.append(value)
        }
    }
    
    // MARK: - Methods
    
    public func getTimestamp() -> Int {
        return timestamp
    }
    
    public func getValues() -> [Float] {
        return values
    }
    
    public func getax() -> Float {
        return values[0]
    }
    
    public func getay() -> Float {
        return values[1]
    }
    
    public func getaz() -> Float {
        return values[2]
    }
    
    public func getwx() -> Float {
        return values[3]
    }
    
    public func getwy() -> Float {
        return values[4]
    }
    
    public func getwz() -> Float {
        return values[5]
    }
    
}
