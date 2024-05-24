//
//  CompanyInfoCollectionViewCell.swift
//  Jumpit
//
//  Created by 이지훈 on 5/16/24.
//

import UIKit

import SnapKit
import Then

class CompanyInfoCollectionViewCell: UICollectionViewCell {
    
    private let logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.text = "회사 소개"
    }

    private let infoView = UIView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.jumpitGray1.cgColor
        $0.layer.cornerRadius = 5
    }
    
    private let infoLabel = UILabel().then {
        $0.textColor = UIColor.jumpitGray4
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.text = "기업정보 보기"
    }

    private let likeView = UIView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.jumpitGray1.cgColor
        $0.layer.cornerRadius = 5
    }
    
    private let heartImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_heart")
        $0.tintColor = .jumpitGray4
        $0.contentMode = .scaleAspectFit
    }
    
    private let likeLabel = UILabel().then {
        $0.text = "좋아요"
        $0.textColor = UIColor.jumpitGray4
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let bottomBar = UIView().then {
        $0.backgroundColor = .jumpitGray1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(infoLabel)
        contentView.addSubview(likeView)
        likeView.addSubview(heartImageView)
        likeView.addSubview(likeLabel)
        contentView.addSubview(bottomBar)

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(20)
            $0.centerY.equalTo(logoImageView.snp.centerY)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(30)
        }
        
        infoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(7)
        }
        
        likeView.snp.makeConstraints {
            $0.leading.equalTo(infoView.snp.trailing).offset(15)
            $0.centerY.equalTo(infoView)
            $0.height.equalTo(30)
        }

        heartImageView.snp.makeConstraints {
            $0.leading.equalTo(likeView.snp.leading).offset(13)
            $0.centerY.equalTo(likeView)
            $0.width.height.equalTo(20)
        }

        likeLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImageView.snp.trailing).offset(13)
            $0.trailing.equalTo(likeView.snp.trailing).inset(13)
            $0.centerY.equalTo(heartImageView)
        }

        likeView.snp.makeConstraints {
            $0.width.equalTo(heartImageView.snp.width).offset(39 + likeLabel.intrinsicContentSize.width)
        }
        
        bottomBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(0) 
            $0.height.equalTo(7)
        }

    }

    func configure(with info: CompanyInfo) {
        titleLabel.text = info.title
        logoImageView.image = info.image
        likeLabel.text = "좋아요"
    }
}
