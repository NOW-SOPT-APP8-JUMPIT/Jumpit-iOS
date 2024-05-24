//
//  ResumeCollectionViewCell.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import UIKit

class ResumeCollectionViewCell: UICollectionViewCell {
    
    
    static let cellID = "resumeCollectionViewCell"
    
    
    private let basicInfoLabel: UILabel = UILabel().then {
        $0.font = CustomFont.body02
        $0.textColor = .jumpitGray5
        $0.text = "기본정보"
    }
    
    private let basicInfoElipseImageView: UIImageView = UIImageView().then {
        $0.image = .icnEllipseRed
        $0.contentMode = .scaleAspectFill
    }
    
    private let techStackInfoLabel: UILabel = UILabel().then {
        $0.font = CustomFont.body02
        $0.textColor = .jumpitGray5
        $0.text = "기술스택"
    }
    
    private let techStackElipseImageView: UIImageView = UIImageView().then {
        $0.image = .icnEllipseRed
        $0.contentMode = .scaleAspectFill
    }
    
    private let educationInfoLabel: UILabel = UILabel().then {
        $0.font = CustomFont.body02
        $0.textColor = .jumpitGray5
        $0.text = "학력"
    }
    
    private let educationElipseImageView: UIImageView = UIImageView().then {
        $0.image = .icnEllipseRed
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var optionButton: UIButton = UIButton().then {
        $0.setImage(.icnOption, for: .normal)
        $0.addTarget(self, action: #selector(didOptionButtonTapped), for: .touchUpInside)
    }
    
    public let resumeNameLabel: UILabel = UILabel().then {
        $0.text = "이력서_240524"
        $0.font = CustomFont.body
        $0.textColor = .black
    }
    
    private let resumeDateLabel: UILabel = UILabel().then {
        $0.text = "2024.05.24 등록"
        $0.textColor = .jumpitGray3
        $0.font = CustomFont.body02
    }
    
    private let resumeStatusView: UIView = UIView().then {
        $0.backgroundColor = .jumpitGray1
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    private let resumeStatusLabel: UILabel = UILabel().then {
        $0.text = "이력서 비공개"
        $0.textColor = .black
        $0.font = CustomFont.body02
    }
    
    public lazy var resumeStatusSwitch: UISwitch = UISwitch().then {
        $0.onTintColor = .jumpitGreen
        $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        $0.addTarget(self, action: #selector(didResumeStatusSwitched), for: .valueChanged)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.jumpitGray2.cgColor
        
        [
            basicInfoLabel, basicInfoElipseImageView, techStackInfoLabel, techStackElipseImageView, educationInfoLabel, educationElipseImageView, optionButton, resumeNameLabel, resumeDateLabel, resumeStatusView, resumeStatusLabel, resumeStatusSwitch
        ].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func setConstraint() {
        basicInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(14)
        }
        
        basicInfoElipseImageView.snp.makeConstraints {
            $0.centerY.equalTo(basicInfoLabel)
            $0.leading.equalTo(basicInfoLabel.snp.trailing).offset(6)
            $0.height.width.equalTo(6)
        }
        
        techStackInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(basicInfoElipseImageView)
            $0.leading.equalTo(basicInfoElipseImageView.snp.trailing).offset(6)
        }
        
        techStackElipseImageView.snp.makeConstraints {
            $0.centerY.equalTo(techStackInfoLabel)
            $0.leading.equalTo(techStackInfoLabel.snp.trailing).offset(6)
            $0.height.width.equalTo(6)
        }
        
        educationInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(techStackInfoLabel)
            $0.leading.equalTo(techStackElipseImageView.snp.trailing).offset(6)
        }
        
        educationElipseImageView.snp.makeConstraints {
            $0.centerY.equalTo(educationInfoLabel)
            $0.leading.equalTo(educationInfoLabel.snp.trailing).offset(6)
            $0.height.width.equalTo(6)
        }
        
        optionButton.snp.makeConstraints {
            $0.centerY.equalTo(educationInfoLabel)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(44)
        }
        
        resumeNameLabel.snp.makeConstraints {
            $0.top.equalTo(basicInfoLabel.snp.bottom).offset(16)
            $0.leading.equalTo(basicInfoLabel)
        }
        
        resumeDateLabel.snp.makeConstraints {
            $0.top.equalTo(resumeNameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(resumeNameLabel)
        }
        
        resumeStatusView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(40)
        }
        
        resumeStatusLabel.snp.makeConstraints {
            $0.centerY.equalTo(resumeStatusView)
            $0.leading.equalTo(resumeStatusView).offset(15)
        }
        
        resumeStatusSwitch.snp.makeConstraints {
            $0.centerY.equalTo(resumeStatusView)
            $0.trailing.equalTo(resumeStatusView).inset(14)
        }
    }
    
    @objc
    private func didOptionButtonTapped() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "editPopUpPresented"), object: nil))
    }
    
    @objc
    private func didResumeStatusSwitched() {
        
    }
}
