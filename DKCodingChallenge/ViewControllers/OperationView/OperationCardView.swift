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
    private var bodyView: UIView!
    
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
        
        title = UILabel()
        title.textColor = .white
        title.numberOfLines = 2
        title.text = "Operation"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        addSubview(title)
        
        bodyView = UIView()
        addSubview(bodyView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints{ make in
            make.left.right.top.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        bodyView.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    public func configure(operation: Operation) {
        title.text = operation.getTitle()
        
        bodyView.removeFromSuperview()
        bodyView = operation.getView()
        addSubview(bodyView)
        bodyView.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }


}
