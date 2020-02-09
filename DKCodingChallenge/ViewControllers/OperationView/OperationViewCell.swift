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

class OperationViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    private var cardView: OperationCardView!
    private var testView: TestCardView!
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
        cardView = OperationCardView()
        cardView.isHidden = true
        addSubview(cardView)
        
        
        testView = TestCardView()
        testView.isHidden = true
        addSubview(testView)
        
        switch displayMode {
        case .operation:
            cardView.isHidden = false
        case .test:
            testView.isHidden = false
        default:
            print("no display mode")
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
        testView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    public func configure(operation: Operation) {
        cardView.configure(operation: operation)
        cardView.button.addTarget(self, action: #selector(toggleCards), for: .touchUpInside)
        
        testView.configure(operation: operation)
        testView.backButton.addTarget(self, action: #selector(toggleCards), for: .touchUpInside)
        self.operation = operation
    }
    
    // MARK: - User Interactions
    
    @objc private func toggleCards() {
        dismissKeyboard()
        switch displayMode {
        case .operation:
            presentTestCardView()
            displayMode = .test
        case .test:
            presentOperationCardView()
            displayMode = .operation
        default:
            print("todo")
        }
    }
    
    private func presentOperationCardView() {
        bringSubviewToFront(testView)
        cardView.isHidden = false
        cardView.alpha = 0
        let origin = self.testView.frame.origin
        UIView.animate(withDuration: 1, animations: {
            self.testView.frame.origin = CGPoint(x: self.testView.frame.origin.x, y: self.testView.frame.origin.y + 600)
            self.cardView.alpha = 1
        }, completion:{ (finished: Bool) -> Void in
            self.testView.isHidden = true
            self.testView.frame.origin = CGPoint(x: self.testView.frame.origin.x, y: self.testView.frame.origin.y - 600)
            self.testView.frame.origin = origin
        })
        
    }
    
    private func presentTestCardView() {
        bringSubviewToFront(testView)
        testView.isHidden = false
        testView.alpha = 1
        let origin = self.testView.frame.origin
        testView.frame.origin = CGPoint(x: self.testView.frame.origin.x, y: self.testView.frame.origin.y + 600)
        UIView.animate(withDuration: 1, animations: {
            self.testView.frame.origin = CGPoint(x: self.testView.frame.origin.x, y: self.testView.frame.origin.y - 600)
            self.cardView.alpha = 0
        }, completion:{ (finished: Bool) -> Void in
            self.cardView.isHidden = true
            self.testView.frame.origin = origin
        })
        
    }
    
    private func dismissKeyboard() {
        print("dismiss")
        endEditing(true)
    }



}
