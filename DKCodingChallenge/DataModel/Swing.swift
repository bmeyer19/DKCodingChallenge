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
    
    private var timestamp : NSNumber!
    private var ax: NSNumber!
    private var ay: NSNumber!
    private var az: NSNumber!
    private var wx: NSNumber!
    private var wy: NSNumber!
    private var wz: NSNumber!
    
    // MARK: - Initializer
    
    // Creates the object from a row of a CSV file
    public init(swingArray: [Substring.SubSequence]) {
        timestamp = NSNumber(value: Int(swingArray[0]) ?? 0)
        ax = NSNumber(value: Float(swingArray[1]) ?? 0)
        ay = NSNumber(value: Float(swingArray[2]) ?? 0)
        az = NSNumber(value: Float(swingArray[3]) ?? 0)
        wx = NSNumber(value: Float(swingArray[4]) ?? 0)
        wy = NSNumber(value: Float(swingArray[5]) ?? 0)
        wz = NSNumber(value: Float(swingArray[6]) ?? 0)
    }
    
    // MARK: - Methods
    
    public func getTimestamp() -> NSNumber {
        return timestamp
    }
    
    public func getColumn(column: Column) -> NSNumber {
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
