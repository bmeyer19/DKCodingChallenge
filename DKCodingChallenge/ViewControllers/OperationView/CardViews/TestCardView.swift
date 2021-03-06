//
//  TestCardView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

// Card in the Operation Collection View
// Lets users toggle parameters and run tests of the various algorithms
class TestCardView: UIView {
    
    // MARK: - Variables
    
    private var title: DKLabel!
    public var backButton: UIButton!
    private var body: UIView!
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
        title.text = "Set Parameters"
        addSubview(title)
        
        backButton = UIButton()
        backButton.setImage(UIImage(named: "iconBack"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        addSubview(backButton)
        
        body = UIView()
        addSubview(body)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(20)
            make.height.width.equalTo(30)
        }
        title.snp.makeConstraints{ make in
            make.top.right.equalToSuperview().inset(20)
            make.left.equalTo(backButton.snp.right).offset(20)
            make.height.equalTo(30)
        }
        body.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(5)
        }
    }
    
    // MARK: - Functions
    
    // resets all current views and adds a parameter view
    public func configure(operation: Operation) {
        for view in subviews {
            view.removeFromSuperview()
        }
        setupViews()
        setupConstraints()
        setupParameterView(view: ParameterView(operation: operation))
    }
    
    // adds a parameter view to the body of the card
    private func setupParameterView(view: UIView) {
        body.addSubview(view)
        view.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }


}
