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
    private var collectionView : OperationView!
    
    private let heightMultiplier : CGFloat = 0.6
    private let verticalInset : CGFloat = 60
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.backgroundColor = .DKBackground
        
        let width = view.frame.width
        let height = view.frame.height * heightMultiplier
        let size = CGSize(width: width, height: height)
        
        let logoImage = UIImage(named: "logo")
        logo = UIImageView(image: logoImage)
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
            
        collectionView = OperationView(size: size)
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        logo.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.bottom.equalTo(collectionView.snp.top).offset(-1 * verticalInset)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height * heightMultiplier)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
        }
    }
    
    // MARK: - User Interactions
    
    @objc private func buttonPressed() {
        DataService.shared.printDataSummary()
    }
    
    // MARK: - Functions


}

