//
//  SearchResultCollectionViewCell.swift
//  Jumpit
//
//  Created by 정민지 on 5/15/24.
//

import UIKit
import Kingfisher
import Then
import SnapKit

final class  SearchResultCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "SearchResultCollectionViewCell"
    
    private let enterpriseImageView = UIImageView().then {
        $0.image = .imgSearchBanner
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    private let enterpriseNameLabel = UILabel().then {
        $0.text = "토스뱅크"
        $0.textColor = .jumpitGray5
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    private let recruitmentNoticeLabel = UILabel().then {
        $0.text = "[토스뱅크] Frontend Developer"
        $0.textColor = .jumpitGray5
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    private let technologyStackLabel = UILabel().then {
        $0.text = "React · TypeScript · Next.js"
        $0.textColor = .jumpitGray4
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    private lazy var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = .icnBmkNormal
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bookMarkTapped))
        $0.addGestureRecognizer(tapGesture)
    }
    
    private var isBookmarked: Bool = false
    var positionId: Int?
    
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
        [enterpriseImageView, enterpriseNameLabel, recruitmentNoticeLabel, technologyStackLabel, bookMarkImageView].forEach {
            self.addSubview($0)
        }
        enterpriseImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(50)
        }
        enterpriseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(enterpriseImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(bookMarkImageView.snp.leading).offset(-5)
        }
        recruitmentNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(enterpriseNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(enterpriseImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(bookMarkImageView.snp.leading).offset(-5)
        }
        technologyStackLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentNoticeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(enterpriseImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(bookMarkImageView.snp.leading).offset(-5)
        }
        bookMarkImageView.snp.makeConstraints {
            $0.centerY.equalTo(recruitmentNoticeLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.width.equalTo(40)
        }
    }
    
    // MARK: - Actions
    @objc private func bookMarkTapped() {
        isBookmarked.toggle()
        updateBookMarkImage()
    }
    private func updateBookMarkImage() {
        let imageName = isBookmarked ? "icn_bmk_selected" : "icn_bmk_normal"
        bookMarkImageView.image = UIImage(named: imageName)
    }
}


extension SearchResultCollectionViewCell {
    func dataBind(_ searchResult: SearchResultModel) {
        self.positionId = searchResult.positionId
        enterpriseNameLabel.text = searchResult.enterpriseName
        recruitmentNoticeLabel.text = searchResult.recruitmentNotice
        technologyStackLabel.text = searchResult.technologyStack.joined(separator: " · ")
        
        if let url = URL(string: searchResult.enterpriseImage) {
            enterpriseImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success(_): break
                    case .failure(let error):
                        print("Failed to load image: \(error.localizedDescription)")
                    }
                }
            )
        } else {
            print("Invalid URL string: \(searchResult.enterpriseImage)")
        }
    }
}

