//
//  differentResumeCollectionViewCell.swift
//  Jumpit
//
//  Created by 이지훈 on 5/15/24.
//

import UIKit

import SnapKit
import Then

class DifferenceResumeCollectionViewCell: UICollectionViewCell {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .jumpitBlueLight
        $0.layer.cornerRadius = 5
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8) 
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
    }
}
