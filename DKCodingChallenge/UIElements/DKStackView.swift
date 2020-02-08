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

    init(arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        for view in arrangedSubviews {
            addArrangedSubview(view)
        }
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
