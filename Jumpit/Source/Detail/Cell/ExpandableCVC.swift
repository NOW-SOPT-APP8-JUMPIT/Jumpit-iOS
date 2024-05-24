//
//  ExpandableCVC.swift
//  Jumpit
//
//  Created by 이지훈 on 5/14/24.

import UIKit

import SnapKit
import Then

class ExpandableJobCell: UICollectionViewCell {
    
    // MARK: - Properties
    var detail: ExpandableJobDetail? {
        didSet { updateContent() }  // 새로운 데이터가 할당될 때 내용 업데이트
    }
    
    var isExpanded: Bool = false {
        didSet { updateAppearance() }  // 확장 상태 변경할때 뷰 업데이트
    }
    
    // MARK: - UI Components
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.numberOfLines = 1
    }
    
    private let jobDetailLabel = UILabel().then {
        $0.isHidden = true
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let stackContainerView = UIView().then {
        $0.isHidden = true
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = UIColor(named: "gray1")
        $0.isHidden = true
    }
    
    private let arrowIndicator = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemGray
    }
    
    private lazy var rootStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(jobDetailLabel)
        $0.addArrangedSubview(stackContainerView)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 8
        
        addSubview(rootStack)
        rootStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(2)
            $0.top.equalTo(stackContainerView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        addSubview(arrowIndicator)
        arrowIndicator.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Update Content
    private func updateContent() {
        guard let detail = detail else { return }
        titleLabel.text = detail.titles.joined(separator: ", ")
        jobDetailLabel.text = detail.jobDetail
        
        stackContainerView.subviews.forEach { $0.removeFromSuperview() }  // Clear existing stack items
        
        if let skills = detail.skills {
            stackContainerView.isHidden = false
            let stackView = UIStackView().then {
                $0.axis = .vertical
                $0.spacing = 5
            }
            
            for skill in skills {
                let skillView = UIView()
                
                let imageView = UIImageView().then {
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                    $0.snp.makeConstraints { $0.size.equalTo(20) }
                }
                if let url = URL(string: skill.image ?? ""), let data = try? Data(contentsOf: url) {
                    imageView.image = UIImage(data: data)
                }
                
                let skillLabel = UILabel().then {
                    $0.font = UIFont(name: "Pretendard-Regular", size: 12)
                    $0.text = skill.name
                }
                
                let skillStack = UIStackView().then {
                    $0.axis = .horizontal
                    $0.spacing = 10
                    $0.addArrangedSubview(imageView)
                    $0.addArrangedSubview(skillLabel)
                }
                
                skillView.addSubview(skillStack)
                skillStack.snp.makeConstraints { $0.edges.equalToSuperview() }
                
                stackView.addArrangedSubview(skillView)
            }
            
            stackContainerView.addSubview(stackView)
            stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        } else {
            stackContainerView.isHidden = true
        }
    }
    
    // MARK: - Update Appearance
    private func updateAppearance() {
        jobDetailLabel.isHidden = !isExpanded
        stackContainerView.isHidden = !isExpanded || (detail?.skills == nil)
        arrowIndicator.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        
        jobDetailLabel.snp.remakeConstraints { make in
            if isExpanded {
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(8)
                make.bottom.lessThanOrEqualTo(stackContainerView.snp.top).offset(-10)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(8)
                make.bottom.lessThanOrEqualTo(stackContainerView.snp.top).offset(-10)
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
