//
//  TestRunView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/8/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

// Reusable view for selecting parameters, testing operations, and displaying results
// Shows different elements depending on the type of operation
class ParameterView: UIView {
    
    // MARK: - Variables
    
    private var button: DKButton!
    private var dataLabel: DKLabelSmall!
    private var dataControl: DKSegmentedControl!
    private var dataLabel2: DKLabelSmall!
    private var dataControl2: DKSegmentedControl!
    private var indexLabelStack: DKStackView!
    private var indexBeginInput: DKTextField!
    private var indexEndInput: DKTextField!
    private var indexStack: DKStackView!
    private var thresholdLabelStack: DKStackView!
    private var threshold1Input: DKTextField!
    private var threshold2Input: DKTextField!
    private var thresholdStack: DKStackView!
    private var winLengthLabel: DKLabelSmall!
    private var winLengthInput: DKTextField!
    private var outputLabel: DKLabelSmall!
    private var outputView: DKTextView!
    private var stack: DKStackView!
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
        
        var dataTitles: [String] = []
        for column in columns {
            dataTitles.append(column.getName())
        }
        
        dataLabel = DKLabelSmall(text: "Data")
        addSubview(dataLabel)
        
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
        let indexInputs : [UIView] = [indexBeginInput, indexEndInput]
        indexStack = DKStackView(arrangedSubviews: indexInputs, axis: .horizontal)
        
        let maxIndex = DataService.shared.getSwingData().count - 1
        switch operation {
        case .backSearchContinuityWithinRange:
            indexBeginInput.text = String(maxIndex)
        default:
            indexEndInput.text = String(maxIndex)
        }
        
        // Setup varying threshold inputs depending on the operation
        let threshold1Label = DKLabelSmall(text: "Threshold Lo")
        let threshold2Label = DKLabelSmall(text: "Threshold Hi")
        threshold1Input = DKTextField(inputType: .float)
        threshold2Input = DKTextField(inputType: .float)
        threshold2Input.text = "1.0"
        let thresholdLabels: [UIView]!
        let thresholdInputs: [UIView]!
        switch operation {
        case .searchContinuityAboveValue:
             thresholdLabels = [threshold1Label]
             thresholdInputs = [threshold1Input]
             threshold1Label.text = "Threshold"
        case .searchContinuityAboveValueTwoSignals:
            thresholdLabels = [threshold1Label, threshold2Label]
            thresholdInputs = [threshold1Input, threshold2Input]
            threshold1Label.text = "Threshold 1"
            threshold2Label.text = "Threshold 2"
        default:
            thresholdLabels = [threshold1Label, threshold2Label]
            thresholdInputs = [threshold1Input, threshold2Input]
        }
        thresholdLabelStack = DKStackView(arrangedSubviews: thresholdLabels, axis: .horizontal)
        thresholdStack = DKStackView(arrangedSubviews: thresholdInputs, axis: .horizontal)
        
        winLengthLabel = DKLabelSmall(text: "Win Length")
        winLengthInput = DKTextField(inputType: .int)
        winLengthInput.text = "1"
        
        outputLabel = DKLabelSmall(text: "Output")
        outputView = DKTextView()
    
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
        // Only setup the second dataset based on the operation
        switch operation {
        case .searchContinuityAboveValueTwoSignals:
            dataLabel2.snp.makeConstraints{ make in
                make.height.equalTo(20)
            }
            dataControl2.snp.makeConstraints{ make in
                make.height.equalTo(40)
            }
        default:
            ()
        }
        // Setup the height of the output based on the operation
        switch operation {
        case .searchMultiContinuityWithinRange:
            outputView.snp.makeConstraints{ make in
                make.height.equalTo(200)
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
        switch operation {
        case .searchMultiContinuityWithinRange:
            scrollToBottom()
        case .searchContinuityAboveValueTwoSignals:
            scrollToBottom()
        default:
            ()
        }
    }
    
    // MARK: - Functions
    
    // Takes the parameters from the interface and tests the operation on them
    private func testOperation() {
        let column = columns[dataControl.selectedSegmentIndex]
        let column2 = columns[dataControl2.selectedSegmentIndex]
        let data = DataService.shared.getColumn(column: column)
        let data2 = DataService.shared.getColumn(column: column2)
        let indexBegin = Int(indexBeginInput.text ?? "0") ?? 0
        let indexEnd = Int(indexEndInput.text ?? "0") ?? 0
        let threshold1Value = Float(threshold1Input.text ?? "0") ?? 0
        let threshold2Value = Float(threshold2Input.text ?? "0") ?? 0
        let winLength = Int(winLengthInput.text ?? "0") ?? 0
        let outputText = DataService.shared.testOperation(
            operation: operation,
            data: data,
            data2: data2,
            indexBegin: indexBegin,
            indexEnd: indexEnd,
            threshold1: threshold1Value,
            threshold2: threshold2Value,
            winLength: winLength)
        outputView.text = outputText
        outputView.flash(color: .systemTeal)
    }
    
    // Checks input before testing the algorithm and provides error messages if something is bad
    private func inputIsValid() -> Bool {
        let indexBegin = Int(indexBeginInput.text ?? "0") ?? 0
        let indexEnd = Int(indexEndInput.text ?? "0") ?? 0
        if indexEnd < DataService.shared.getSwingData().count{
            if indexBegin < DataService.shared.getSwingData().count {
                if let text1 = threshold1Input.text, let text2 = threshold2Input.text {
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
                        threshold1Input.flash(color: .systemRed)
                        threshold2Input.flash(color: .systemRed)
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
    
    private func scrollToBottom() {
        let bottomOffset: CGPoint = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom);
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
}


