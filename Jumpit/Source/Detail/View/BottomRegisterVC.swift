//
//  bottomRegisterVC.swift
//  Jumpit
//
//  Created by 이지훈 on 5/21/24.
//

import UIKit
import SnapKit
import Then

class BottomRegisterViewController: UIViewController {
    
    private let firstView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.jumpitGray1.cgColor
        $0.layer.cornerRadius = 3
    }
    
    private let secondView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.jumpitGray2.cgColor
        $0.layer.cornerRadius = 3
    }
    
    private let thirdView = UIView().then {
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 3
    }
    
    private let firstImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_bmk_detail")
        $0.contentMode = .center
    }
    
    private let secondImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_coach_robotics")
        $0.contentMode = .center
    }
    
    private let applyLabel = UILabel().then {
        $0.text = "지원하기"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)

    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 9
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupStackView()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstView)
        firstView.addSubview(firstImageView)
        firstImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(secondView)
        secondView.addSubview(secondImageView)
        secondImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(thirdView)
        thirdView.addSubview(applyLabel)
        applyLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        firstView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
        
        secondView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
        
        thirdView.snp.makeConstraints {
            $0.width.equalTo(227)
            $0.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
    }
}
