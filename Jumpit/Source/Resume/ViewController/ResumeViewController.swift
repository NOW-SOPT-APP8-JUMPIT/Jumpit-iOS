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
    
    private let resumePopupImageView: UIImageView = UIImageView().then {
        $0.image = .imgPopupResume
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    
    private lazy var resumeAddButton: UIButton = UIButton().then {
        $0.setImage(.icnAdd, for: .normal)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didResumeAddButtonTapped), for: .touchUpInside)
    }
    
    private lazy var resumeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 13
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(ResumeCollectionViewCell.self, forCellWithReuseIdentifier: ResumeCollectionViewCell.cellID)
    }
    
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
    
    private let filePopupImageView: UIImageView = UIImageView().then {
        $0.image = .imgPopupFile
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    
    private lazy var fileAddButton: UIButton = UIButton().then {
        $0.setImage(.icnAdd, for: .normal)
        $0.contentMode = .scaleAspectFill
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
        setDelegate()
        setUpNotification()
        
    }
    
    private func setNavigationBar() {
        self.navigationItem.setLeftBarButton(leftResumeBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItems![0].isHidden = true
        self.navigationItem.rightBarButtonItems![2].isHidden = true
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        
        [
            myResumeInfoLabel, resumeNumberLabel, resumeHelpButton, resumeAddButton, blankResumeImageView, resumeCollectionView, seperateView, fileInfoLabel, fileNumberLabel, fileHelpButton, fileAddButton, blankFileImageView, ellipseView, fileDescriptionLabel, filePopupImageView, resumePopupImageView
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
            $0.height.equalTo(188)
        }
        
        resumeCollectionView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(blankResumeImageView)
            $0.trailing.equalToSuperview()
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
        
        resumePopupImageView.snp.makeConstraints {
            $0.top.equalTo(resumeHelpButton.snp.bottom).offset(6.5)
            $0.leading.equalTo(resumeHelpButton)
            $0.height.equalTo(176)
            $0.width.equalTo(174)
        }
        
        filePopupImageView.snp.makeConstraints {
            $0.top.equalTo(fileHelpButton.snp.bottom).offset(6.5)
            $0.leading.equalTo(fileHelpButton)
            $0.height.equalTo(94)
            $0.width.equalTo(174)
        }
    }
    
    private func setDelegate() {
        resumeCollectionView.dataSource = self
        resumeCollectionView.delegate = self
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didOptionButtonTapped), name: NSNotification.Name("editPopUpPresented"), object: nil)
    }
    
    @objc
    private func didOptionButtonTapped() {
        let resumeEditViewController = ResumeEditViewController()
        
        resumeEditViewController.modalTransitionStyle = .crossDissolve
        resumeEditViewController.modalPresentationStyle = .overFullScreen
        
        self.present(resumeEditViewController, animated: true)
    }
    
    @objc
    private func didResumeHelpButtonTapped() {
        resumePopupImageView.isHidden.toggle()
        
        resumePopupImageView.isHidden ? resumeHelpButton.setImage(.icnHelp, for: .normal) : resumeHelpButton.setImage(.icnHelpSelect, for: .normal)
    }
    
    @objc
    private func didResumeAddButtonTapped() {
        let resumeAddViewController = ResumeAddViewController()
        
        resumeAddViewController.modalTransitionStyle = .crossDissolve
        resumeAddViewController.modalPresentationStyle = .overFullScreen
        
        self.present(resumeAddViewController, animated: true)
    }
    
    @objc
    private func didFileHelpButtonTapped() {
        filePopupImageView.isHidden.toggle()
        
        filePopupImageView.isHidden ? fileHelpButton.setImage(.icnHelp, for: .normal) : fileHelpButton.setImage(.icnHelpSelect, for: .normal)
    }
}


extension ResumeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 358, height: 188)
    }
}

extension ResumeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeCollectionViewCell.cellID, for: indexPath) as? ResumeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
