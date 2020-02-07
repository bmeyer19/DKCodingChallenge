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
        backgroundColor = .DKAccent
        
        button = DKButton()
        button.setTitle("Run", for: .normal)
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    // MARK: - User Interactions
    
    // MARK: - Functions
    
    
    
}


