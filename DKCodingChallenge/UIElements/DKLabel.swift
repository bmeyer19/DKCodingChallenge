//
//  DKLabel.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class DKLabel: UILabel {

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        textColor = .white
        font = UIFont.init(name: "Futura-Medium", size: 18)
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
