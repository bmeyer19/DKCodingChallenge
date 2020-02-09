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
    private var dataLabel2: UILabel!
    private var dataControl2: UISegmentedControl!
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
    private var scrollView: UIScrollView!
    
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
        
        dataLabel2 = DKLabelSmall(text: "Data2")
        addSubview(dataLabel2)
        
        dataControl2 = DKSegmentedControl(titles: dataTitles)
        addSubview(dataControl2)
        
        let indexBeginLabel = DKLabelSmall(text: "Index Begin")
        let indexEndLabel = DKLabelSmall(text: "Index End")
        let indexLabels : [UILabel] = [indexBeginLabel, indexEndLabel]
        indexLabelStack = DKStackView(arrangedSubviews: indexLabels, axis: .horizontal)
        
        indexBeginInput = DKTextField(inputType: .int)
        indexEndInput = DKTextField(inputType: .int)
        indexEndInput.text = String(DataService.shared.getSwingData().count - 1)
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
        winLengthInput.text = "1"
        
        outputLabel = DKLabelSmall(text: "Output")
        outputView = DKTextView()
    
        scrollView = UIScrollView()
        addSubview(scrollView)
        
        let inputViews: [UIView]!
        switch operation {
        case .searchContinuityAboveValueTwoSignals:
            inputViews = [dataLabel, dataControl, dataLabel2, dataControl2, indexLabelStack, indexStack, thresholdLabelStack, thresholdStack, winLengthLabel, winLengthInput, outputLabel, outputView]
        default:
            inputViews = [dataLabel, dataControl, indexLabelStack, indexStack, thresholdLabelStack, thresholdStack, winLengthLabel, winLengthInput, outputLabel, outputView]
        }
        stack = DKStackView(arrangedSubviews: inputViews, axis: .vertical)
        scrollView.addSubview(stack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(button.snp.top).inset(-20)
        }
        stack.snp.makeConstraints{ make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
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
        }
        switch operation {
        case .searchContinuityAboveValueTwoSignals:
            dataLabel2.snp.makeConstraints{ make in
                make.height.equalTo(20)
            }
            dataControl2.snp.makeConstraints{ make in
                make.height.equalTo(40)
            }
        default:
            print("only one dataset")
        }
        switch operation {
        case .searchMultiContinuityWithinRange:
            outputView.snp.makeConstraints{ make in
                make.height.equalTo(100)
            }
        default:
            outputView.snp.makeConstraints{ make in
                make.height.equalTo(40)
            }
        }
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    // MARK: - User Interactions
    
    @objc private func buttonPressed() {
        if inputIsValid() {
            testOperation()
        }
    }
    
    // MARK: - Functions
    
    private func testOperation() {
        let column = columns[dataControl.selectedSegmentIndex]
        let data = DataService.shared.getColumn(column: column)
        let data2 = DataService.shared.getColumn(column: column)
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
                outputView.text = "No Such Continuity Found"
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
                outputView.text = "No Such Continuity Found"
            }
        case .searchContinuityAboveValueTwoSignals:
            let result = CodingChallenge.shared.searchContinuityAboveValueTwoSignals(
                data1: data,
                data2: data2,
                indexBegin: indexBegin,
                indexEnd: indexEnd,
                threshold1: threshold1Value,
                threshold2: threshold2Value,
                winLength: winLength)
            if let output = result {
                outputView.text = String(output)
            } else {
                outputView.text = "No Such Continuity Found"
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
    
    private func inputIsValid() -> Bool {
        let indexBegin = Int(indexBeginInput.text ?? "0") ?? 0
        let indexEnd = Int(indexEndInput.text ?? "0") ?? 0
        if indexEnd < DataService.shared.getSwingData().count{
            if indexBegin < DataService.shared.getSwingData().count {
                if let text1 = threshold1.text, let text2 = threshold2.text {
                    if let _ = Float(text1), let _ = Float(text2) {
                        switch operation {
                        case .backSearchContinuityWithinRange:
                            if indexEnd > indexBegin {
                                indexEndInput.flash(color: .systemRed)
                                outputView.flash(color: .systemRed)
                                outputView.text = "End Index > Begin Index"
                            } else {
                                return true
                            }
                        default:
                            if indexEnd < indexBegin {
                                indexBeginInput.flash(color: .systemRed)
                                outputView.flash(color: .systemRed)
                                outputView.text = "Begin Index > End Index"
                            } else {
                                return true
                            }
                        }
                    } else {
                        threshold1.flash(color: .systemRed)
                        threshold2.flash(color: .systemRed)
                        outputView.flash(color: .systemRed)
                        outputView.text = "Invalid Threshold"
                    }
                }

            } else {
                indexBeginInput.flash(color: .systemRed)
                outputView.flash(color: .systemRed)
                outputView.text = "Index out of range"
            }
        } else {
            indexEndInput.flash(color: .systemRed)
            outputView.flash(color: .systemRed)
            outputView.text = "Index out of range"
        }
        return false
    }
    
}


