//
//  EmptyResultView.swift
//  Jumpit
//
//  Created by 정민지 on 5/24/24.
//

import UIKit
import Then
import SnapKit

final class EmptyResultView: UIView {
    // MARK: - Properties
    private let mainLabel = UILabel().then {
        $0.text = "등록된 결과가 없어요."
        $0.textColor = .jumpitGray4
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.numberOfLines = 0
    }
    private let subLabel = UILabel().then {
        $0.text =  "새로운 검색어로\n나에게 맞는 공고를 찾아봐요!"
        $0.textColor = .jumpitGray4
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.numberOfLines = 0
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
        [mainLabel, subLabel].forEach {
            self.addSubview($0)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
