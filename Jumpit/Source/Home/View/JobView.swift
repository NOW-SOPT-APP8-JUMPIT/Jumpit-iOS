//
//  JobView.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import UIKit

class JobView: UIView {
    
    
    private let jobImageView: UIImageView = UIImageView().then {
        $0.image = .icnIosfront
        $0.contentMode = .scaleAspectFit
    }
    
    private let jobLabel: UILabel = UILabel().then {
        $0.text = "iOS 개발자"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = CustomFont.body
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setLayout()
        setConstraint()
    }
    
    private func setLayout() {
        [
            jobImageView, jobLabel
        ].forEach {
            self.addSubview($0)
        }
    }
    
    private func setConstraint() {
        jobImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(36)
        }
        
        jobLabel.snp.makeConstraints {
            $0.top.equalTo(jobImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    public func bindData(_ label: String, _ image: UIImage) {
        jobImageView.image = image
        jobLabel.text = label
    }
}
