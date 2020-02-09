//
//  DKTextView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

// Reusable view for displaying text.
class DKTextView: UITextView {

    // MARK: - Initialization

    init() {
        super.init(frame: .zero, textContainer: nil)
        textColor = .white
        backgroundColor = .DKBodyLight
        font = UIFont.init(name: "Gill Sans", size: 16)
        layer.cornerRadius = 5
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        isEditable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
