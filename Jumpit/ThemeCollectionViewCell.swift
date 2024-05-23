//
//  ThemeCollectionViewCell.swift
//  Jumpit
//
//  Created by YOUJIM on 5/23/24.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    
    static let cellID = "themeCollectionViewCell"
    
    public let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
    }
    
    private func setConstraint() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(263)
            $0.height.equalTo(84)
        }
    }
}
