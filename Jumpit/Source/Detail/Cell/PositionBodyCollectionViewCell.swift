//
//  PositionBodyCollectionViewCell.swift
//  Jumpit
//
//  Created by 이지훈 on 5/17/24.
//

import UIKit
import SnapKit
import Then

class PositionBodyCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .jumpitGray4
    }
    
    let mainTitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .black
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .jumpitGray4
    }
    
    private let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .jumpitGray1
    }
    
    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [titleLabel, mainTitleLabel, descriptionLabel].forEach(textStackView.addArrangedSubview)
        [imageView, textStackView, bookImageView, separatorView].forEach(addSubview)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        textStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(bookImageView.snp.leading).offset(-20)
        }
        
        bookImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        separatorView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(77)
        }
    }
    
    func configure(with detail: PositionDetail) {
        imageView.image = detail.image
        titleLabel.text = detail.title
        mainTitleLabel.text = detail.subtitle
        descriptionLabel.text = detail.description
        bookImageView.image = detail.isBookmarked ? UIImage(named: "icn_bmk_selected") : UIImage(named: "icn_bmk_normal")
    }
    
}
