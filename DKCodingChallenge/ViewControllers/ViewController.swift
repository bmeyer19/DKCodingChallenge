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
    
    private var collectionView : OperationView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.backgroundColor = .DKBackground
        
        let width = view.frame.width
        let height = view.frame.width
        let size = CGSize(width: width, height: height)
            
        collectionView = OperationView(size: size)
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(collectionView.snp.width)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - User Interactions
    
    @objc private func buttonPressed() {
        DataService.shared.printDataSummary()
    }
    
    // MARK: - Functions


}

