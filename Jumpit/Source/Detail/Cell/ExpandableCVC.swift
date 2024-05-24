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
        $0.isHidden = false
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
        
        stackContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        if let skills = detail.skills {
            stackContainerView.isHidden = false
            
            var lastSkillView: UIView? = nil
            for skill in skills {
                let skillView = UIView().then {
                    $0.backgroundColor = .jumpitGray1
                    $0.layer.cornerRadius = 5
                }
                
                let imageView = UIImageView().then {
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                }
                if let url = URL(string: skill.image ?? ""), let data = try? Data(contentsOf: url) {
                    imageView.image = UIImage(data: data)
                }
                
                let skillLabel = UILabel().then {
                    $0.font = UIFont(name: "Pretendard-Regular", size: 12)
                    $0.text = skill.name
                }
                
                skillView.addSubview(imageView)
                skillView.addSubview(skillLabel)
                
                imageView.snp.makeConstraints {
                    $0.leading.equalToSuperview().offset(10)
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(20)
                }
                
                skillLabel.snp.makeConstraints {
                    $0.leading.equalTo(imageView.snp.trailing).offset(10)
                    $0.centerY.equalToSuperview()
                    $0.trailing.equalToSuperview().offset(-10)
                }
                
                skillView.snp.makeConstraints {
                    $0.height.equalTo(31)
                    $0.width.greaterThanOrEqualTo(0)
                }
                
                stackContainerView.addSubview(skillView)
                skillView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    if let lastSkillView = lastSkillView {
                        make.leading.equalTo(lastSkillView.snp.trailing).offset(10)
                    } else {
                        make.leading.equalToSuperview().offset(10)
                    }
                    make.bottom.equalToSuperview().offset(-10)
                }
                
                lastSkillView = skillView
            }
        }
    }
    
    // MARK: - Update Appearance
    private func updateAppearance() {
        jobDetailLabel.isHidden = !isExpanded
        stackContainerView.isHidden = !isExpanded || (detail?.skills == nil)
        separatorView.isHidden = false
        arrowIndicator.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        
        if isExpanded {
            jobDetailLabel.snp.remakeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(8)
            }
            stackContainerView.snp.remakeConstraints {
                $0.top.equalTo(jobDetailLabel.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.bottom.lessThanOrEqualTo(separatorView.snp.top).offset(-10)
            }
        } else {
            jobDetailLabel.snp.remakeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.bottom.equalTo(separatorView.snp.top).offset(-10)
            }
            stackContainerView.snp.remakeConstraints {
                $0.top.equalTo(jobDetailLabel.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(8)
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
