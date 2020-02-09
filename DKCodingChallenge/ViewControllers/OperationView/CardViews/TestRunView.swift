//
//  TestRunView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

class TestRunView: UIView {
    
    // MARK: - Variables
    
    private var button: UIButton!
    private var dataLabel: UILabel!
    private var dataControl: UISegmentedControl!
    private var indexLabelStack: UIStackView!
    private var indexBeginInput: UITextField!
    private var indexEndInput: UITextField!
    private var indexStack: UIStackView!
    private var thresholdLabelStack: UIStackView!
    private var threshold1: UITextField!
    private var threshold2: UITextField!
    private var thresholdStack: UIStackView!
    private var winLengthLabel: UILabel!
    private var winLengthInput: UITextField!
    private var outputLabel: UILabel!
    private var outputView: UITextView!
    private var stack: UIStackView!
    
    private var operation: Operation!
    private var columns: [Column] = [.ax,.ay,.az,.wx,.wy,.wz]
    
    // MARK: - Initialization
    
    init(operation: Operation) {
        super.init(frame: .zero)
        self.operation = operation
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
        
        dataLabel = DKLabelSmall(text: "Data")
        addSubview(dataLabel)
        
        var dataTitles: [String] = []
        for column in columns {
            dataTitles.append(column.getName())
        }
        dataControl = DKSegmentedControl(titles: dataTitles)
        addSubview(dataControl)
        
        let indexBeginLabel = DKLabelSmall(text: "Index Begin")
        let indexEndLabel = DKLabelSmall(text: "Index End")
        let indexLabels : [UILabel] = [indexBeginLabel, indexEndLabel]
        indexLabelStack = DKStackView(arrangedSubviews: indexLabels, axis: .horizontal)
        
        indexBeginInput = DKTextField(inputType: .int)
        indexEndInput = DKTextField(inputType: .int)
        let indexInputs : [UIView] = [indexBeginInput, indexEndInput]
        indexStack = DKStackView(arrangedSubviews: indexInputs, axis: .horizontal)
        
        let threshold1Label = DKLabelSmall(text: "Threshold Lo")
        let threshold2Label = DKLabelSmall(text: "Threshold Hi")
        threshold1 = DKTextField(inputType: .float)
        threshold2 = DKTextField(inputType: .float)
        let thresholdLabels: [UIView]!
        let thresholdInputs: [UIView]!
        switch operation {
        case .searchContinuityAboveValue:
             thresholdLabels = [threshold1Label]
             thresholdInputs = [threshold1]
             threshold1Label.text = "Threshold"
        case .searchContinuityAboveValueTwoSignals:
            thresholdLabels = [threshold1Label, threshold2Label]
            thresholdInputs = [threshold1, threshold2]
            threshold1Label.text = "Threshold 1"
            threshold2Label.text = "Threshold 2"
        default:
            thresholdLabels = [threshold1Label, threshold2Label]
            thresholdInputs = [threshold1, threshold2]
        }
        thresholdLabelStack = DKStackView(arrangedSubviews: thresholdLabels, axis: .horizontal)
        thresholdStack = DKStackView(arrangedSubviews: thresholdInputs, axis: .horizontal)
        
        winLengthLabel = DKLabelSmall(text: "Win Length")
        winLengthInput = DKTextField(inputType: .int)
        
        outputLabel = DKLabelSmall(text: "Output")
        outputView = DKTextView()
        
        let inputViews : [UIView] = [dataLabel, dataControl, indexLabelStack, indexStack, thresholdLabelStack, thresholdStack, winLengthLabel, winLengthInput, outputLabel, outputView]
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
            make.height.equalTo(20)
            make.height.equalTo(dataLabel.snp.height)
            make.height.equalTo(thresholdLabelStack.snp.height)
            make.height.equalTo(winLengthLabel.snp.height)
            make.height.equalTo(outputLabel.snp.height)
        }
        indexStack.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.height.equalTo(dataControl.snp.height)
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
        let indexBegin = Int(indexBeginInput.text ?? "0") ?? 0
        let indexEnd = Int(indexEndInput.text ?? "0") ?? 0
        switch operation {
        case .backSearchContinuityWithinRange:
            if indexEnd > indexBegin {
                indexEndInput.flash(color: .systemRed)
            } else {
                testOperation()
            }
        default:
            if indexEnd < indexBegin {
                indexBeginInput.flash(color: .systemRed)
            } else {
                testOperation()
            }
        }
    }
    
    // MARK: - Functions
    
    private func testOperation() {
        let column = columns[dataControl.selectedSegmentIndex]
        let data = DataService.shared.getColumn(column: column)
        let indexBegin = Int(indexBeginInput.text ?? "0") ?? 0
        let indexEnd = Int(indexEndInput.text ?? "0") ?? 0
        let threshold1Value = Float(threshold1.text ?? "0") ?? 0
        let threshold2Value = Float(threshold2.text ?? "0") ?? 0
        let winLength = Int(winLengthInput.text ?? "0") ?? 0
        
        switch operation {
        case .searchContinuityAboveValue:
            let result = CodingChallenge.shared.searchContinuityAboveValue(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                threshold: threshold1Value,
                winLength: winLength)
            if let output = result {
                outputView.text = String(output)
            } else {
                outputView.text = "none"
            }
        case .backSearchContinuityWithinRange:
            let result = CodingChallenge.shared.backSearchContinuityWithinRange(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                thresholdLo: threshold1Value,
                thresholdHi: threshold2Value,
                winLength: winLength)
            if let output = result {
                outputView.text = String(output)
            } else {
                outputView.text = "none"
            }
        case .searchContinuityAboveValueTwoSignals:
            let result = CodingChallenge.shared.searchContinuityAboveValueTwoSignals(
                data1: data,
                data2: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                threshold1: threshold1Value,
                threshold2: threshold2Value,
                winLength: winLength)
            if let output = result {
                outputView.text = String(output)
            } else {
                outputView.text = "none"
            }
        case .searchMultiContinuityWithinRange:
            let result = CodingChallenge.shared.searchMultiContinuityWithinRange(
                data: data,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                thresholdLo: threshold1Value,
                thresholdHi: threshold2Value,
                winLength: winLength)
            outputView.text = result.description
        default:
            print("No Operation Selected")
        }
        outputView.flash(color: .systemTeal)
    }
    
}


