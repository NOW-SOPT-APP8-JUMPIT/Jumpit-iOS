//
//  HomeSearchButton.swift
//  Jumpit
//
//  Created by YOUJIM on 5/17/24.
//

import UIKit

class HomeSearchButton: UIButton {
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func setLayout() {
        setTitle("'Python'을 검색해보세요", for: .normal)
        setTitleColor(.black, for: .normal)
        setImage(.icnSearch, for: .normal)
        titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        layer.cornerRadius = 26
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        contentHorizontalAlignment = .left
    }
}
