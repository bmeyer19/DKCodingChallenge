//
//  DKSegmentedControl.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

// Reusable Segmented Control
class DKSegmentedControl: UISegmentedControl {
    
    // MARK: - Initialization

    init(titles: [String]) {
        super.init(frame: .zero)
        for (index, title) in titles.enumerated() {
            insertSegment(withTitle: title, at: index, animated: false)
        }
        backgroundColor = .DKBodyLight
        selectedSegmentTintColor = .DKAccent
        selectedSegmentIndex = 0
        layer.cornerRadius = 5
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
