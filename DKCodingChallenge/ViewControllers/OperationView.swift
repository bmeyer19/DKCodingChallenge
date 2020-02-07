//
//  OperationView.swift
//  DKCodingChallenge
//
//  Created by Ben Meyer on 2/6/20.
//  Copyright © 2020 bmeyer. All rights reserved.
//

import UIKit
import SnapKit

class OperationView: UIView {
    
    // MARK: - Variables
    
    private var collectionView : UICollectionView!
    private let cellId = "operationCell"
    private var size : CGSize!

    // MARK: - Lifecycle
    
    init(size: CGSize) {
        super.init(frame: .zero)
        self.size = size
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        
        collectionView = OperationCollectionView(size: size)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OperationViewCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

}

extension OperationView : UICollectionViewDelegate {
    
}

extension OperationView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OperationViewCell
        return cell
    }
    
    
}


