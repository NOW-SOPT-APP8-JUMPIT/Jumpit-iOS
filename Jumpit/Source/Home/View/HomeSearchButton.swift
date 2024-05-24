//
//  HomeSearchButton.swift
//  Jumpit
//
//  Created by YOUJIM on 5/17/24.
//

import UIKit

class HomeSearchButton: UIButton {
    
    
    private var config = UIButton.Configuration.plain()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func setLayout() {
        setTitle("'Python'을 검색해보세요", for: .normal)
        setTitleColor(.black, for: .normal)
        setImage(.icnSearchGreen, for: .normal)
        imageView?.backgroundColor = .clear
        imageView?.contentMode = .scaleAspectFill
        titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        layer.cornerRadius = 26
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        contentHorizontalAlignment = .left
    }
    
    private func setConfiguration() {
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)
        
        configuration = config
    }
}
