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
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .jumpitGray1
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
            $0.top.equalTo(jobDetailLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        
        addSubview(arrowIndicator)
        arrowIndicator.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Update Content
    func updateContent() {
            guard let detail = detail else { return }
            titleLabel.text = detail.titles.joined(separator: ", ")
            jobDetailLabel.text = detail.jobDetail
            separatorView.isHidden = false
        }
    
    // MARK: - Update Appearance
     private func updateAppearance() {
         jobDetailLabel.isHidden = !isExpanded
         arrowIndicator.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
         
         jobDetailLabel.snp.remakeConstraints { make in
             if isExpanded {
                 make.top.equalTo(titleLabel.snp.bottom).offset(20)
                 make.leading.trailing.equalToSuperview().inset(8)
                 make.bottom.lessThanOrEqualTo(separatorView.snp.top).offset(-10)
             } else {
                 make.top.equalTo(titleLabel.snp.bottom).offset(10)
                 make.leading.trailing.equalToSuperview().inset(8)
                 make.bottom.lessThanOrEqualTo(separatorView.snp.top).offset(-10)
             }
         }
         
         UIView.animate(withDuration: 0.3) {
             self.layoutIfNeeded()
         }
     }
}
