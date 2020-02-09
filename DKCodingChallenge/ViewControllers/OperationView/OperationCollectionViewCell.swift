//
//  OperationViewCell.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

public enum DisplayMode {
    case operation
    case test
}

// Cell that contains 2 cards which can be toggled
class OperationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    private var operationCardView: OperationCardView!
    private var testCardView: TestCardView!
    private var operation: Operation!
    private var displayMode: DisplayMode!
    private var cardOrigin: CGPoint!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        displayMode = .operation
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Setup
    
    private func setupViews() {
        operationCardView = OperationCardView()
        operationCardView.isHidden = true
        addSubview(operationCardView)
        
        testCardView = TestCardView()
        testCardView.isHidden = true
        addSubview(testCardView)
        
        switch displayMode {
        case .operation:
            operationCardView.isHidden = false
        case .test:
            testCardView.isHidden = false
        default:
            print("no display mode")
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        operationCardView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        testCardView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    public func configure(operation: Operation) {
        operationCardView.configure(operation: operation)
        operationCardView.button.addTarget(self, action: #selector(toggleCards), for: .touchUpInside)
        
        testCardView.configure(operation: operation)
        testCardView.backButton.addTarget(self, action: #selector(toggleCards), for: .touchUpInside)
        self.operation = operation
    }
    
    // MARK: - User Interactions
    
    // Switches between the test card view and the operation card view
    @objc private func toggleCards() {
        switch displayMode {
        case .operation:
            presentTestCardView()
            displayMode = .test
        case .test:
            presentOperationCardView()
            displayMode = .operation
        default:
            ()
        }
    }
    
    // Animation to hide the test card view and show the operation card view
    private func presentOperationCardView() {
        bringSubviewToFront(testCardView)
        operationCardView.isHidden = false
        operationCardView.alpha = 0
        let origin = self.testCardView.frame.origin
        UIView.animate(withDuration: 1, animations: {
            self.testCardView.frame.origin = CGPoint(x: self.testCardView.frame.origin.x, y: self.testCardView.frame.origin.y + 600)
            self.operationCardView.alpha = 1
        }, completion:{ (finished: Bool) -> Void in
            self.testCardView.isHidden = true
            self.testCardView.frame.origin = CGPoint(x: self.testCardView.frame.origin.x, y: self.testCardView.frame.origin.y - 600)
            self.testCardView.frame.origin = origin
        })
    }
    
    // Animation to hide the operation card view and show the test card view
    private func presentTestCardView() {
        bringSubviewToFront(testCardView)
        testCardView.isHidden = false
        testCardView.alpha = 1
        let origin = self.testCardView.frame.origin
        testCardView.frame.origin = CGPoint(x: self.testCardView.frame.origin.x, y: self.testCardView.frame.origin.y + 600)
        UIView.animate(withDuration: 1, animations: {
            self.testCardView.frame.origin = CGPoint(x: self.testCardView.frame.origin.x, y: self.testCardView.frame.origin.y - 600)
            self.operationCardView.alpha = 0
        }, completion:{ (finished: Bool) -> Void in
            self.operationCardView.isHidden = true
            self.testCardView.frame.origin = origin
        })
    }

}
