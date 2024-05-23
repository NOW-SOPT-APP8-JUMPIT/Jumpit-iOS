//
//  SortCategoryCollectionViewCell.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import Then
import SnapKit

final class  SortCategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "SortCategoryCollectionViewCell"
    
    private let categoryLabel = UILabel().then {
        $0.text = "직무"
        $0.textColor = .jumpitGray6
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    private let downArrowImageView = UIImageView().then {
        $0.image = .icnToggledown
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [categoryLabel, downArrowImageView].forEach {
            self.addSubview($0)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(downArrowImageView.snp.leading).offset(-9)
        }
        downArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(categoryLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(9)
        }
    }
    
    private func setupLayer() {
        self.layer.cornerRadius = 17
        self.layer.borderColor = UIColor.jumpitGray2.cgColor
        self.layer.borderWidth = 1
    }
}


extension SortCategoryCollectionViewCell {
    func dataBind(_ category: CategoryModel) {
        categoryLabel.text = category.title
    }
}
