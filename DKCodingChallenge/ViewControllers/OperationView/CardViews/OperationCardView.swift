//
//  OperationCardView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class OperationCardView: UIView {
    
    // MARK: - Variables
    
    private var title: UILabel!
    private var body: UITextView!
    public var button: UIButton!
    private var operation: Operation!
    
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        applyShadow(color: .black)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = .DKBody
        layer.cornerRadius = 5
        
        title = DKLabel()
        title.numberOfLines = 2
        addSubview(title)
        
        body = DKTextView()
        addSubview(body)
        
        button = DKButton()
        button.setTitle("Test", for: .normal)
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        body.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(button.snp.top).offset(-20)
        }
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    

    
    // MARK: - Functions
    
    public func configure(operation: Operation) {
        title.text = operation.getTitle()
        body.text = operation.getText()
    }


}
