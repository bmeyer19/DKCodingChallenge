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
    private var button: UIButton!
    
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
        backgroundColor = .DKBody
        layer.cornerRadius = 5
        applyShadow(color: .black)
        
        title = UILabel()
        title.textColor = .white
        title.text = "Operation"
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        addSubview(title)
        
        button = UIButton()
        button.setTitle("Run", for: .normal)
        button.backgroundColor = .DKBodyLight
        button.layer.cornerRadius = 5
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints{ make in
            make.left.right.top.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

}
