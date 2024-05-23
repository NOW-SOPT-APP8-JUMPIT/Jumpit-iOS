//
//  JobOptionCollectionViewCell.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

final class JobOptionCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "JobOptionCollectionViewCell"
    
    private var selectedJobOptions: Set<String> {
        return SelectedJobOptionsModel.shared.selectedOptions
    }
    
    private lazy var button = UIButton().then {
        $0.setTitleColor(.jumpitGray4, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.backgroundColor = .jumpitGray1
        $0.layer.cornerRadius = 3
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(jobButtonTapped), for: .touchUpInside)
        $0.contentEdgeInsets = UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 15)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func jobButtonTapped() {
        guard let title = button.title(for: .normal) else { return }
       if SelectedJobOptionsModel.shared.selectedOptions.contains(title) {
        SelectedJobOptionsModel.shared.removeOption(title)
        button.backgroundColor = .jumpitGray1
        button.setTitleColor(.jumpitGray4, for: .normal)
        button.layer.borderWidth = 0
    } else {
        SelectedJobOptionsModel.shared.addOption(title)
        button.backgroundColor = .white
        button.setTitleColor(.jumpitGreen, for: .normal)
        button.layer.borderColor = UIColor.jumpitGreen.cgColor
        button.layer.borderWidth = 1
    }
    }
}

extension JobOptionCollectionViewCell {
    func dataBind(with title: String, isSelected: Bool) {
        button.setTitle(title, for: .normal)
        
        if isSelected {
            button.backgroundColor = .white
            button.setTitleColor(.jumpitGreen, for: .normal)
            button.layer.borderColor = UIColor.jumpitGreen.cgColor
            button.layer.borderWidth = 1
        } else {
            button.backgroundColor = .jumpitGray1
            button.setTitleColor(.jumpitGray4, for: .normal)
            button.layer.borderWidth = 0
        }
    }
}
