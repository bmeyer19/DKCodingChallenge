//
//  DKStackView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class DKStackView: UIStackView {

    // MARK: - Initialization

    init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        for view in arrangedSubviews {
            addArrangedSubview(view)
        }
        self.axis = axis
        self.alignment = .fill
        switch axis {
        case .vertical:
            distribution = .equalSpacing
            spacing = 7.5
        case .horizontal:
            distribution = .fillEqually
            spacing = 20
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
