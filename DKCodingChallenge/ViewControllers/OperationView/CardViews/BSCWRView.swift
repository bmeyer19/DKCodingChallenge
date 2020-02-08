//
//  BSCWRView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

class BSCWRView: UIView {
    // MARK: - Variables
    
    private var button: UIButton!
    private var indexLabelStack: UIStackView!
    private var indexBeginInput: UITextField!
    private var indexEndInput: UITextField!
    private var indexStack: UIStackView!
    private var thresholdLabelStack: UIStackView!
    private var thresholdLoInput: UITextField!
    private var thresholdHiInput: UITextField!
    private var thresholdStack: UIStackView!
    private var winLengthLabel: UILabel!
    private var winLengthInput: UITextField!
    private var outputLabel: UILabel!
    private var outputView: UITextView!
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
        
        let indexBeginLabel = DKLabelSmall(text: "indexBegin")
        let indexEndLabel = DKLabelSmall(text: "indexEnd")
        let indexLabels : [UILabel] = [indexBeginLabel, indexEndLabel]
        indexLabelStack = DKStackView(arrangedSubviews: indexLabels, axis: .horizontal)
        
        indexBeginInput = DKTextField(inputType: .int)
        indexEndInput = DKTextField(inputType: .int)
        let indexInputs : [UIView] = [indexBeginInput, indexEndInput]
        indexStack = DKStackView(arrangedSubviews: indexInputs, axis: .horizontal)
        
        let thresholdLoLabel = DKLabelSmall(text: "thresholdLo")
        let thresholdHiLabel = DKLabelSmall(text: "thresholdHi")
        let thresholdLabels: [UIView] = [thresholdLoLabel, thresholdHiLabel]
        thresholdLabelStack = DKStackView(arrangedSubviews: thresholdLabels, axis: .horizontal)
        
        thresholdLoInput = DKTextField(inputType: .float)
        thresholdHiInput = DKTextField(inputType: .float)
        let thresholdInputs: [UIView] = [thresholdLoInput, thresholdHiInput]
        thresholdStack = DKStackView(arrangedSubviews: thresholdInputs, axis: .horizontal)
        
        winLengthLabel = DKLabelSmall(text: "winLength")
        winLengthInput = DKTextField(inputType: .int)
        
        outputLabel = DKLabelSmall(text: "Output")
        outputView = DKTextView()
        
        let inputViews : [UIView] = [indexLabelStack, indexStack, thresholdLabelStack, thresholdStack, winLengthLabel, winLengthInput, outputLabel, outputView]
        stack = DKStackView(arrangedSubviews: inputViews, axis: .vertical)
        addSubview(stack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(button.snp.top).inset(-20)
        }
        indexLabelStack.snp.makeConstraints{ make in
            make.height.equalTo(25)
            make.height.equalTo(thresholdLabelStack.snp.height)
            make.height.equalTo(winLengthLabel.snp.height)
            make.height.equalTo(outputLabel.snp.height)
        }
        indexStack.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.height.equalTo(thresholdStack.snp.height)
            make.height.equalTo(winLengthInput.snp.height)
            make.height.equalTo(outputView.snp.height)
        }
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    // MARK: - User Interactions
    
    @objc private func buttonPressed() {
        let data = DataService.shared.getSwingData()
        let result = CodingChallenge.shared.backSearchContinuityWithinRange(
            data: data,
            indexBegin: Int(indexBeginInput.text ?? "0") ?? 0,
            indexEnd: Int(indexEndInput.text ?? "0") ?? 0,
            thresholdLo: Float(thresholdLoInput.text ?? "0") ?? 0,
            thresholdHi: Float(thresholdHiInput.text ?? "0") ?? 0,
            winLength: Int(winLengthInput.text ?? "0") ?? 0)
        if let output = result {
            outputView.text = String(output)
        } else {
            outputView.text = "none"
        }
        outputView.flash(color: .DKAccent)
        
    }
    
}


