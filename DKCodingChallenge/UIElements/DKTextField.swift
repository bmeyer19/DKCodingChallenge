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
            text = "0.0"
        case .int:
            keyboardType = .numberPad
            text = "0"
        }
        keyboardAppearance = .dark
        setupAccessoryView()
    }
    
    private func setupAccessoryView() {
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = .DKAccent
        let bar = UIToolbar()
        bar.items = [flexible, doneButton]
        bar.backgroundColor = .DKBody
        bar.sizeToFit()
        print(UIScreen.main.bounds.height)
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: UIScreen.main.bounds.height))
        customView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        customView.addSubview(bar)
        bar.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        inputAccessoryView = customView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }

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
