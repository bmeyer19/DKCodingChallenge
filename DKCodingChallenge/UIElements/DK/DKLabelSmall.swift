//
//  DKLabelSmall.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

// Reusable small label for input fields
class DKLabelSmall: UILabel {
    
    // MARK: - Initialization

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        textColor = .white
        font = UIFont.init(name: "Gill Sans", size: 16)
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
