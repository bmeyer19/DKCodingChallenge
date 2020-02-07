//
//  UIColor + Util.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let DKAccent = colorFromCode(0x71AF65)
    static let DKBackground = colorFromCode(0x121212)
    static let DKBody = colorFromCode(0x282828)
    static let DKBodyLight = colorFromCode(0x393939)
    
    class func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat((code & 0xFF0000) >> 16) / 255
        let green = CGFloat((code & 0xFF00) >> 8) / 255
        let blue = CGFloat(code & 0xFF) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
