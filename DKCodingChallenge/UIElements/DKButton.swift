//
//  DKButton.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class DKButton: UIButton {
    
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        backgroundColor = .DKAccent
        setTitleColor(.white, for: .normal)
        setTitleColor(.DKBodyLight, for: .highlighted)
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
