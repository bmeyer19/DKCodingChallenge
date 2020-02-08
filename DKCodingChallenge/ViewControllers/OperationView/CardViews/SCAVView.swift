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
    private var indexLabelStack: UIStackView!
    private var indexBeginInput: UITextField!
    private var indexEndInput: UITextField!
    private var indexStack: UIStackView!
    private var thresholdLabel: UILabel!
    private var thresholdInput: UITextField!
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
        
        thresholdLabel = DKLabelSmall(text: "threshold")
        thresholdInput = DKTextField(inputType: .float)
        
        winLengthLabel = DKLabelSmall(text: "winLength")
        winLengthInput = DKTextField(inputType: .int)
        
        outputLabel = DKLabelSmall(text: "Output")
        outputView = DKTextView()
        
        let inputViews : [UIView] = [indexLabelStack, indexStack, thresholdLabel, thresholdInput, winLengthLabel, winLengthInput, outputLabel, outputView]
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
            make.height.equalTo(thresholdLabel.snp.height)
            make.height.equalTo(winLengthLabel.snp.height)
            make.height.equalTo(outputLabel.snp.height)
        }
        indexStack.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.height.equalTo(thresholdInput.snp.height)
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
        print(Int(indexBeginInput.text ?? "0") ?? 0)
        print(Int(indexEndInput.text ?? "0") ?? 0)
        let result = CodingChallenge.shared.searchContinuityAboveValue(
            data: data,
            indexBegin: Int(indexBeginInput.text ?? "0") ?? 0,
            indexEnd: Int(indexEndInput.text ?? "0") ?? 0,
            threshold: Float(thresholdInput.text ?? "0") ?? 0,
            winLength: Int(winLengthInput.text ?? "0") ?? 0)
        if let output = result {
            outputView.text = String(output)
        } else {
            outputView.text = "none"
        }
        outputView.flash(color: .DKAccent)
        
    }
    
}
