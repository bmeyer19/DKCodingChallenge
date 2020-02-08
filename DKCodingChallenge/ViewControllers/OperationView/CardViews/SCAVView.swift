//
//  SCAVView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

class SCAVView: UIView {
    
    // MARK: - Variables
    
    private var button: UIButton!
    private var indexBeginInput: UITextField!
    private var indexEndInput: UITextField!
    private var outputField: UITextView!
    private var stack: UIStackView!
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        button = DKButton()
        button.setTitle("Run", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(button)
        
        indexBeginInput = DKTextField(inputType: .int)
        
        indexEndInput = DKTextField(inputType: .int)
        
        outputField = DKTextView()
        outputField.text = "Output"

        
        let inputViews : [UIView] = [indexBeginInput, indexEndInput, outputField]
        stack = DKStackView(arrangedSubviews: inputViews)
        addSubview(stack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(button.snp.top).inset(-20)
        }
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        indexBeginInput.snp.makeConstraints{ make in
            make.height.equalTo(45)
        }
        indexEndInput.snp.makeConstraints{ make in
            make.height.equalTo(45)
        }
        outputField.snp.makeConstraints{ make in
            make.height.equalTo(45)
        }
    }
    
    // MARK: - User Interactions
    
    @objc private func buttonPressed() {
        let data = DataService.shared.getSwingData()
        let result = CodingChallenge.shared.searchContinuityAboveValue(
            data: data,
            indexBegin: 5,
            indexEnd: 50,
            threshold: 4,
            winLength: 3)
        print(result)
    }
    
    // MARK: - Functions
    
    private func dismissKeyboard() {
        for view in stack.arrangedSubviews {
            print(view.description)
            if view.isFirstResponder {
                view.resignFirstResponder()
            }
        }
    }
    
}


