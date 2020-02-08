//
//  DKTextField.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

enum InputType {
    case float
    case int
}

class DKTextField: UITextField {
    
    // MARK: - Variables
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    // MARK: - Initialization

    init(inputType: InputType) {
        super.init(frame: .zero)
        backgroundColor = .DKBodyLight
        font = UIFont.init(name: "Gill Sans", size: 16)
        textColor = .white
        layer.cornerRadius = 5
        placeholder = String(0)
        delegate = self
        tintColor = .DKAccent
        switch inputType {
        case .float:
            keyboardType = .decimalPad
        case .int:
            keyboardType = .numberPad
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

extension DKTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
}
