//
//  Swing.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/3/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import Foundation

//
public struct Swing {
    
    // MARK: - Variables
    
    private var timestamp : Int!
    private var ax: Float!
    private var ay: Float!
    private var az: Float!
    private var wx: Float!
    private var wy: Float!
    private var wz: Float!
    
    // MARK: - Initializer
    
    // Creates the object from a row of a CSV file
    public init(swingArray: [Substring.SubSequence]) {
        timestamp = Int(swingArray[0]) ?? 0
        ax = Float(swingArray[1]) ?? 0
        ay = Float(swingArray[2]) ?? 0
        az = Float(swingArray[3]) ?? 0
        wx = Float(swingArray[4]) ?? 0
        wy = Float(swingArray[5]) ?? 0
        wz = Float(swingArray[6]) ?? 0
    }
    
    // MARK: - Methods
    
    public func getTimestamp() -> Int {
        return timestamp
    }
    
    public func getColumn(column: Column) -> Float {
        switch column {
        case .ax:
            return ax
        case .ay:
            return ay
        case .az:
            return az
        case .wx:
            return wx
        case .wy:
            return wy
        case .wz:
            return wz
        }
    }
    
}
