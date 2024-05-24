//
//  PlaceholderCell.swift
//  Jumpit
//
//  Created by 이지훈 on 5/24/24.
//

import UIKit

class PlaceholderCell: UICollectionViewCell {
    private let placeholderView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(placeholderView)
        placeholderView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
