//
//  ViewController.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/3/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private var logo: UIImageView!
    private var label: UILabel!
    private var collectionView : OperationView!
    
    private let heightMultiplier : CGFloat = 0.725
    private let verticalInset : CGFloat = 20
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.backgroundColor = .DKBackground
        
        let width = view.frame.width
        let height = UIScreen.main.bounds.height * heightMultiplier
        let size = CGSize(width: width, height: height)
        
        let logoImage = UIImage(named: "logo")
        logo = UIImageView(image: logoImage)
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        
        label = DKLabel()
        label.text = "Coding Challenge - Ben Meyer"
        label.textAlignment = .center
        view.addSubview(label)
                    
        collectionView = OperationView(size: size)
        view.addSubview(collectionView)
        
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupConstraints() {
        
        logo.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        label.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top).offset(-1 * verticalInset / 2)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * heightMultiplier)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - User Interactions
    
    // MARK: - Functions

    @objc private func keyboardWillShow() {
        collectionView.frame.origin = CGPoint(x: collectionView.frame.origin.x, y: collectionView.frame.origin.y - 95)
        logo.alpha = 0
        label.alpha = 0
    }
    
    @objc private func keyboardWillHide() {
        collectionView.frame.origin = CGPoint(x: collectionView.frame.origin.x, y: collectionView.frame.origin.y + 95)
        logo.alpha = 1
        label.alpha = 1
    }

}

