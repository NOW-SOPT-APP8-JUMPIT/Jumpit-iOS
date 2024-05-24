//
//  ResumeEditViewController.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import UIKit

class ResumeEditViewController: UIViewController {
    
    
    private let bottomView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    private lazy var dismissButton: UIButton = UIButton().then {
        $0.setImage(.icnX, for: .normal)
        $0.addTarget(self, action: #selector(didDismissButtonTapped), for: .touchUpInside)
    }
    
    private let editInfoLabel: UILabel = UILabel().then {
        $0.font = CustomFont.subTitle02
        $0.text = "편집"
        $0.textColor = .black
    }
    
    private lazy var previewResumeButton: UIButton = UIButton().then {
        $0.setTitle("이력서 미리보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = CustomFont.body
        $0.contentHorizontalAlignment = .leading
    }
    
    private lazy var copyResumeButton: UIButton = UIButton().then {
        $0.setTitle("이력서 복사하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .leading
        $0.titleLabel?.font = CustomFont.body
    }
    
    private lazy var deleteResumeButton: UIButton = UIButton().then {
        $0.setTitle("이력서 삭제하기", for: .normal)
        $0.setTitleColor(.jumpitRed, for: .normal)
        $0.contentHorizontalAlignment = .leading
        $0.titleLabel?.font = CustomFont.body
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setConstraint()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    private func setLayout() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        view.addSubview(bottomView)
        [
            dismissButton, editInfoLabel, previewResumeButton, copyResumeButton, deleteResumeButton
        ].forEach {
            bottomView.addSubview($0)
        }
    }
    
    private func setConstraint() {
        bottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(242)
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(14)
            $0.height.width.equalTo(44)
        }
        
        editInfoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(dismissButton)
        }
        
        previewResumeButton.snp.makeConstraints {
            $0.top.equalTo(editInfoLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
        
        copyResumeButton.snp.makeConstraints {
            $0.top.equalTo(previewResumeButton.snp.bottom)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
        
        deleteResumeButton.snp.makeConstraints {
            $0.top.equalTo(copyResumeButton.snp.bottom)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
    }
    
    @objc
    private func didDismissButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func didAddResumeButtonTapped() {
        
    }
}
