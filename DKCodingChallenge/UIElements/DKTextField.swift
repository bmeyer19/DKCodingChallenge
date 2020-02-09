//
//  DKTextField.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

// Type of input to gather with the keyboard
enum InputType {
    case float
    case int
}

// Reusable text field for input
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
        setupKeyboard(inputType: inputType)
        setupAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup
    
    private func setupKeyboard(inputType: InputType) {
        keyboardAppearance = .dark
        switch inputType {
        case .float:
            keyboardType = .numbersAndPunctuation
            text = "0.0"
        case .int:
            keyboardType = .numberPad
            text = "0"
        }
    }
    
    // Sets up everything above the keyboard, when the keyboard is active
    private func setupAccessoryView() {
        // Creates a transparent view to block the screen behind the keyboard.
        // Dismisses the keyboard when pressed
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height))
        customView.addGestureRecognizer(tapGesture)
        
        // Basic toolbar with done button
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = .DKAccent
        let bar = UIToolbar()
        bar.items = [flexible, doneButton]
        bar.backgroundColor = .DKBody
        bar.sizeToFit()
        customView.addSubview(bar)
        bar.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        inputAccessoryView = customView
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
