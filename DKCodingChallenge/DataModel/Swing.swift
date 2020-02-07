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
    
    private var timestamp : Int;
    private var ax : Float;
    private var ay : Float;
    private var az : Float;
    private var wx : Float;
    private var wy : Float;
    private var wz : Float;
    
    // MARK: - Initializer
    
    public init(_ timestamp : Int, _ ax : Float, _ ay : Float, _ az : Float, _ wx : Float, _ wy : Float, _ wz : Float) {
        self.timestamp = timestamp
        self.ax = ax
        self.ay = ay
        self.az = az
        self.wx = wx
        self.wy = wy
        self.wz = wz
    }
    
    public init(swingArray : [Substring.SubSequence]) {
        self.timestamp = Int(swingArray[0]) ?? 0
        self.ax = Float(swingArray[1]) ?? 0
        self.ay = Float(swingArray[2]) ?? 0
        self.az = Float(swingArray[3]) ?? 0
        self.wx = Float(swingArray[4]) ?? 0
        self.wy = Float(swingArray[5]) ?? 0
        self.wz = Float(swingArray[6]) ?? 0
    }
    
    // MARK: - Methods
    
    public func getTimestamp() -> Int {
        return timestamp
    }
    
    public func getax() -> Float {
        return ax
    }
    
    public func getay() -> Float {
        return ay
    }
    
    public func getaz() -> Float {
        return az
    }
    
    public func getwx() -> Float {
        return wx
    }
    
    public func getwy() -> Float {
        return wy
    }
    
    public func getwz() -> Float {
        return wz
    }
    
}
