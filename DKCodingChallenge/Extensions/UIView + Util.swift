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
    
    public func flash(color: UIColor) {
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = color.withAlphaComponent(0.5)
        }, completion: { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundColor = .DKBodyLight
            })
        })
    }
    
}
