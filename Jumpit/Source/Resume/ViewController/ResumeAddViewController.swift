//
//  ResumeAddViewController.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import UIKit
import Moya

class ResumeAddViewController: UIViewController {
    
    private let provider = MoyaProvider<ResumesAPI>()

    private let bottomView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    private lazy var dismissButton: UIButton = UIButton().then {
        $0.setImage(.icnX, for: .normal)
        $0.addTarget(self, action: #selector(didDismissButtonTapped), for: .touchUpInside)
    }
    
    private let addInfoLabel: UILabel = UILabel().then {
        $0.font = CustomFont.subTitle02
        $0.text = "추가"
        $0.textColor = .black
    }
    
    private lazy var addResumeButton: UIButton = UIButton().then {
        $0.setTitle("이력서 추가하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = CustomFont.body
        $0.contentHorizontalAlignment = .leading
        $0.addTarget(self, action: #selector(didAddResumeButtonTapped), for: .touchUpInside)
    }
    
    private lazy var fetchResumeButton: UIButton = UIButton().then {
        $0.setTitle("사람인 이력서 가져오기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
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
            dismissButton, addInfoLabel, addResumeButton, fetchResumeButton
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
        
        addInfoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(dismissButton)
        }
        
        addResumeButton.snp.makeConstraints {
            $0.top.equalTo(addInfoLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
        
        fetchResumeButton.snp.makeConstraints {
            $0.top.equalTo(addResumeButton.snp.bottom).offset(14)
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
        let resumeTitle = "민지가 취업을 한대요!"
        print(resumeTitle)
        postResume(with: resumeTitle)
    }
    
    func postResume(with title: String) {
        let resumeData = ResumeData(title: title, userId: 1)
        
        provider.request(.postResume(data: resumeData)) { result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONDecoder().decode(PrivateResumeResponse.self, from: response.data)
                    if responseData.status == 201 {
                        print(responseData.message + "고마워 민지야!")
                        
                        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "resumeAdded"), object: nil))
                        
                        self.dismiss(animated: true)
                        
                    } else {
                        print("Failed to add resume: \(responseData.message)")
                    }
                } catch {
                    print("Failed to decode response: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
}
