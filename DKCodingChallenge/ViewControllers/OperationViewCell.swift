//
//  OperationViewCell.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class OperationViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    private var cardView: OperationCardView!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Setup
    
    private func setupViews() {
        cardView = OperationCardView()
        addSubview(cardView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(10)
        }
    }

}
