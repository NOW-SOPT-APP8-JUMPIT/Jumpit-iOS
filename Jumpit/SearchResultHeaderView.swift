//
//  SearchResultHeaderView.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

final class SearchResultHeaderView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "SearchResultHeaderView"
    
    private let positionLabel = UILabel().then {
        $0.text = "포지션"
        $0.textColor = .jumpitGray5
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    private let numLabel = UILabel().then {
        $0.text = "(10)"
        $0.textColor = .jumpitGreen
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [positionLabel, numLabel].forEach {
            self.addSubview($0)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(22)
        }
        numLabel.snp.makeConstraints {
            $0.centerY.equalTo(positionLabel.snp.centerY)
            $0.leading.equalTo(positionLabel.snp.trailing).offset(1)
        }
    }
}

extension SearchResultHeaderView {
    func dataBind(_ resultCount: Int) {
        numLabel.text = "(\(resultCount))"
    }
}
