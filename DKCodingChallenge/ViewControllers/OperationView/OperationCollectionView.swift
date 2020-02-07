//
//  OperationCollectionView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit

class OperationCollectionView: UICollectionView {
    
    // MARK: - Variables
    
    private let inset: CGFloat = 50
    
    // MARK: - Initialization
    
    init(size: CGSize) {
        let cellWidth = size.width - inset * 2
        let cellHeight = size.height - 20
        
        let layout = OperationViewLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        self.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
