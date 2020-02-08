//
//  TestCardView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/7/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class TestCardView: UIView {
    
    // MARK: - Variables
    
    private var title: UILabel!
    public var backButton: UIButton!
    private var body: UIView!
    private var operation: Operation!
    
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        applyShadow(color: .black)
        setupViews()
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(handle(keyboardShowNotification:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(handleHide(keyboardShowNotification:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = .DKBody
        layer.cornerRadius = 5
        
        title = DKLabel()
        title.text = "Setup Test"
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
            make.top.equalTo(backButton.snp.bottom)
        }
    }
    

    
    // MARK: - Functions
    
    public func configure(operation: Operation) {
        switch operation {
        case .searchContinuityAboveValue:
            setupTestView(view: SCAVView())
        case .backSearchContinuityWithinRange:
            setupTestView(view: BSCWRView())
        case .searchContinuityAboveValueTwoSignals:
            setupTestView(view: SCAVTSView())
        case .searchMultiContinuityWithinRange:
            setupTestView(view: SMCWRView())
        default:
            print("none")
        }
    }
    
    private func setupTestView(view: UIView) {
        body.addSubview(view)
        view.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func handle(keyboardShowNotification notification: Notification) {
        /*let distance = UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.6 + 120)
        UIView.animate(withDuration: 1, animations:{
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y - distance)
        })*/
    }
    
    @objc private func handleHide(keyboardShowNotification notification: Notification) {
        /*let distance = UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.6 + 120)
        UIView.animate(withDuration: 1, animations:{
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + distance)
        })*/
    }


}
