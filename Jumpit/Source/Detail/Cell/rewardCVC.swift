//
//  rewardCVC.swift
//  Jumpit
//
//  Created by 이지훈 on 5/20/24.

import UIKit

import SnapKit
import Then

class rewardCVC: UICollectionViewCell {
    
    let rewardImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true  
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(rewardImageView)
        rewardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with image: UIImage?) {
        rewardImageView.image = image
    }
}
