//
//  JDCVC.swift
//  Jumpit
//
//  Created by 이지훈 on 5/13/24.
//

import UIKit

import SnapKit
import Then

class JDCVC: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
    }
    private let descLabel = UILabel().then {
        $0.textColor = UIColor.gray
        $0.numberOfLines = 2
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    private let careerLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.textColor = .black
    }
    private let educationLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.textColor = .black
    }
    private let deadlineLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.textColor = .black
    }
    private let locationLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.textColor = .black
    }
    private let career = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .black
    }
    private let education = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .black
    }
    private let deadline = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .black
    }
    private let location = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .black
    }
    private let mapButtonLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .jumpitGray4
        $0.text = "지도 보기"
    }

    private let copyAddressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .green
        $0.text = "주소 복사"
    }

    private let mapButtonImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "icn_place")
    }

    private let copyAddressImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "icn_duplicate")
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let views = [
            imageView, titleLabel, descLabel, careerLabel,
            educationLabel, deadlineLabel, locationLabel,
            career, education, deadline, location,
            mapButtonLabel, copyAddressLabel,
            mapButtonImageView, copyAddressImageView
        ]
        views.forEach { contentView.addSubview($0) }
        
        backgroundColor = .white
    }


    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
            $0.height.width.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
        }

        descLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }

        careerLabel.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        educationLabel.snp.makeConstraints {
            $0.top.equalTo(careerLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }

        deadlineLabel.snp.makeConstraints {
            $0.top.equalTo(educationLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(deadlineLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }

        career.snp.makeConstraints {
            $0.leading.equalTo(careerLabel.snp.trailing).offset(34)
            $0.centerY.equalTo(careerLabel.snp.centerY)
        }
        
        education.snp.makeConstraints {
            $0.leading.equalTo(educationLabel.snp.trailing).offset(34)
            $0.centerY.equalTo(educationLabel.snp.centerY)
        }

        deadline.snp.makeConstraints {
            $0.leading.equalTo(deadlineLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(deadlineLabel.snp.centerY)
        }

        location.snp.makeConstraints {
            $0.leading.equalTo(locationLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(locationLabel.snp.centerY)
        }
        
        mapButtonImageView.snp.makeConstraints {
             $0.top.equalTo(location.snp.bottom).offset(15)
             $0.leading.equalToSuperview().inset(76)
             $0.width.height.equalTo(24)
         }

         mapButtonLabel.snp.makeConstraints {
             $0.leading.equalTo(mapButtonImageView.snp.trailing).offset(1)
             $0.centerY.equalTo(mapButtonImageView.snp.centerY)
         }

         copyAddressImageView.snp.makeConstraints {
             $0.top.equalTo(mapButtonImageView.snp.top)
             $0.leading.equalTo(mapButtonLabel.snp.trailing).offset(7)
             $0.width.height.equalTo(24)
         }

         copyAddressLabel.snp.makeConstraints {
             $0.leading.equalTo(copyAddressImageView.snp.trailing).offset(1)
             $0.centerY.equalTo(copyAddressImageView.snp.centerY)
             $0.trailing.lessThanOrEqualToSuperview().inset(16)
         }
    }

    func configure(with detail: JobDetail) {
        imageView.image = detail.image
        titleLabel.text = detail.title
        descLabel.text = detail.description

        careerLabel.text = detail.careerLabel
        educationLabel.text = detail.educationLabel
        deadlineLabel.text = detail.deadlineLabel
        locationLabel.text = detail.locationLabel
        
        career.text = detail.career
        education.text = detail.education
        deadline.text = detail.deadline
        location.text = detail.location
    }
}

