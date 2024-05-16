//
//  RecentSearchTableViewCell.swift
//  Jumpit
//
//  Created by 정민지 on 5/15/24.
//

import UIKit
import Then
import SnapKit

final class  RecentSearchTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "RecentSearchTableViewCell"
    
    var onDelete: (() -> Void)?
    
    private let searchKeywordLabel = UILabel().then {
        $0.text = "ar"
        $0.textColor = .jumpitGray5
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
    }
    private lazy var cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_x_small"), for: .normal)
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        $0.tintColor = .jumpitGray4
    }

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [searchKeywordLabel, cancelButton ].forEach {
            contentView.addSubview($0)
        }
        searchKeywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(9)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-5)
        }
        cancelButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(24)
        }
    }
    
    // MARK: - Action
    @objc private func cancelButtonTapped() {
        guard let keyword = searchKeywordLabel.text else { return }
        RecentSearchModel.shared.removeSearch(keyword: keyword)
        onDelete?()
    }
}


extension RecentSearchTableViewCell {
    func dataBind(_ recentKeyword: String) {
        searchKeywordLabel.text = recentKeyword
    }
}
