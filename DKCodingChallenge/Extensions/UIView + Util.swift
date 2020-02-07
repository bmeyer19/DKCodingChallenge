//
//  UIView + Util.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

extension UIView {
    
    public func applyShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.2
    }
    
}
