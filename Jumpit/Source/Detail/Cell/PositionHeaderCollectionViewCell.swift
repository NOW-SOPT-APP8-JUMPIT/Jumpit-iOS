//
//  PositionHeaderCollectionViewCell.swift
//  Jumpit
//
//  Created by 이지훈 on 5/17/24.
//
import UIKit

import SnapKit
import Then

class PositionHeaderCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textColor = .black
        $0.text = "지금보는 포지션과 유사해요"
    }

    private let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_notification_green")
        $0.contentMode = .scaleAspectFit
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(iconImageView)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(37)
        }

        iconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(40)
        }
    }
}
