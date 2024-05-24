//
//  ResumeViewController.swift
//  Jumpit
//
//  Created by YOUJIM on 5/16/24.
//

import UIKit

class ResumeViewController: UIViewController {
    
    
    private let leftResumeBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.title = "이력서"
        $0.setTitleTextAttributes([NSAttributedString.Key.font: CustomFont.title01, NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
    private let myResumeInfoLabel: UILabel = UILabel().then {
        $0.text = "나의 이력서"
        $0.font = UIFont.font(.pretendardBold, ofSize: 18)
        $0.textColor = .black
    }
    
    private let resumeNumberLabel: UILabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.font(.pretendardBold, ofSize: 18)
        $0.textColor = .jumpitGreen
    }
    
    private lazy var resumeHelpButton: UIButton = UIButton().then {
        $0.setImage(.icnHelp, for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didResumeHelpButtonTapped), for: .touchUpInside)
    }
    
    private lazy var resumeAddButton: UIButton = UIButton().then {
        $0.setImage(.icnAdd, for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didResumeAddButtonTapped), for: .touchUpInside)
    }
    
//    private lazy var
    
    private let blankResumeImageView: UIImageView = UIImageView().then {
        $0.image = .imgNoResume
        $0.contentMode = .scaleAspectFill
    }
    
    private let seperateView: UIView = UIView().then {
        $0.backgroundColor = .jumpitGray1
    }
    
    private let fileInfoLabel: UILabel = UILabel().then {
        $0.text = "첨부파일"
        $0.textColor = .black
        $0.font = UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    private let fileNumberLabel: UILabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .jumpitGreen
        $0.font = UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    private lazy var fileHelpButton: UIButton = UIButton().then {
        $0.setImage(.icnHelp, for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didFileHelpButtonTapped), for: .touchUpInside)
    }
    
    private lazy var fileAddButton: UIButton = UIButton().then {
        $0.setImage(.icnAdd, for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didFileAddButtonTapped), for: .touchUpInside)
    }
    
    private let blankFileImageView: UIImageView = UIImageView().then {
        $0.image = .imgNoFile
        $0.contentMode = .scaleAspectFill
    }
    
    private let ellipseView: UIImageView = UIImageView().then {
        $0.image = .icnEllipseGray
        $0.contentMode = .scaleAspectFill
    }
    
    private let fileDescriptionLabel: UILabel = UILabel().then {
        $0.text = "첨부파일 미리보기는 pdf만 가능합니다."
        $0.font = CustomFont.body02
        $0.textColor = .jumpitGray5
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setLayout()
        setConstraint()
    }
    
    private func setNavigationBar() {
        self.navigationItem.setLeftBarButton(leftResumeBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItems![0].isHidden = true
        self.navigationItem.rightBarButtonItems![2].isHidden = true
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        
        [
            myResumeInfoLabel, resumeNumberLabel, resumeHelpButton, resumeAddButton, blankResumeImageView, seperateView, fileInfoLabel, fileNumberLabel, fileHelpButton, fileAddButton, blankFileImageView, ellipseView, fileDescriptionLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraint() {
        myResumeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        resumeNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(myResumeInfoLabel)
            $0.leading.equalTo(myResumeInfoLabel.snp.trailing).offset(7)
        }
        
        resumeHelpButton.snp.makeConstraints {
            $0.centerY.equalTo(myResumeInfoLabel)
            $0.leading.equalTo(resumeNumberLabel.snp.trailing).offset(4)
            $0.height.width.equalTo(18)
        }
        
        resumeAddButton.snp.makeConstraints {
            $0.centerY.equalTo(myResumeInfoLabel)
            $0.trailing.equalToSuperview().inset(2)
            $0.height.width.equalTo(44)
        }
        
        blankResumeImageView.snp.makeConstraints {
            $0.top.equalTo(myResumeInfoLabel.snp.bottom).offset(25)
            $0.leading.equalTo(myResumeInfoLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(178)
        }
        
        seperateView.snp.makeConstraints {
            $0.top.equalTo(blankResumeImageView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(13)
        }
        
        fileInfoLabel.snp.makeConstraints {
            $0.top.equalTo(seperateView.snp.bottom).offset(33)
            $0.leading.equalToSuperview().offset(16)
        }
        
        fileNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(fileInfoLabel)
            $0.leading.equalTo(fileInfoLabel.snp.trailing).offset(7)
        }
        
        fileHelpButton.snp.makeConstraints {
            $0.centerY.equalTo(fileInfoLabel)
            $0.leading.equalTo(fileNumberLabel.snp.trailing).offset(4)
            $0.height.width.equalTo(18)
        }
        
        fileAddButton.snp.makeConstraints {
            $0.centerY.equalTo(fileInfoLabel)
            $0.trailing.equalToSuperview().inset(2)
            $0.height.width.equalTo(44)
        }
        
        blankFileImageView.snp.makeConstraints {
            $0.top.equalTo(fileInfoLabel.snp.bottom).offset(25)
            $0.leading.equalTo(fileInfoLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
        }
        
        ellipseView.snp.makeConstraints {
            $0.top.equalTo(blankFileImageView.snp.bottom).offset(17.5)
            $0.leading.equalTo(fileInfoLabel)
            $0.height.width.equalTo(14)
        }
        
        fileDescriptionLabel.snp.makeConstraints {
            $0.centerY.equalTo(ellipseView)
            $0.leading.equalTo(ellipseView.snp.trailing).offset(4)
        }
    }
    
    @objc
    private func didResumeHelpButtonTapped() {
        
    }
    
    @objc
    private func didResumeAddButtonTapped() {
        
    }
    
    @objc
    private func didFileHelpButtonTapped() {
        
    }
    
    @objc
    private func didFileAddButtonTapped() {
        
    }
}
