//
//  SortCategoryView.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

protocol SortCategoryViewDelegate: AnyObject {
    func didSelectSearchButton()
}

final class SortCategoryView: UIView {
    // MARK: - Properties
    weak var delegate: SortCategoryViewDelegate?
    
    private let handleView = UIView().then {
        $0.backgroundColor = .jumpitGray2
        $0.layer.cornerRadius = 8
    }
    private let filterStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillProportionally
    }
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout())

    private lazy var searchButton = UIButton().then {
        $0.setTitle("검색", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private let filterOptions: [String] = ["직무", "경력", "태그", "기술스택", "지역"]
    private let jobOptions: [String] = [
        "서버/백엔드 개발자",
        "프론트엔드 개발자",
        "웹 풀스택 개발자",
        "안드로이드 개발자",
        "iOS 개발자",
        "크로스플랫폼 앱개발자",
        "게임 클라이언트 개발자",
        "게임 서버 개발자",
        "DBA",
        "빅데이터 엔지니어",
        "인공지능/머신러닝",
        "devops/시스템 엔지니어",
        "정보보안 담당자",
        "QA 엔지니어",
        "개발 PM",
        "HW/임베디드",
        "SW/솔루션",
        "웹퍼블리셔",
        "VR/AR/3D",
        "블록체인",
        "기술지원"
    ]
    private var selectedJobOptions: Set<String> {
        return SelectedJobOptionsModel.shared.selectedOptions
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [handleView, collectionView, searchButton].forEach {
            self.addSubview($0)
        }
        
        handleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(11)
            $0.width.equalTo(35)
            $0.height.equalTo(4)
        }

        let filterLabels = filterOptions.enumerated().map { (index, title) -> UILabel in
            return createLabel(title: title, isHighlighted: index == 0)
        }
        filterLabels.forEach { filterStackView.addArrangedSubview($0) }
        addSubview(filterStackView)
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(handleView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(22)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(searchButton.snp.top).offset(-20)
        }
        searchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(39)
        }
    }
    
    // MARK: - SetupCollectionView
    private func setupCollectionView() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(JobOptionCollectionViewCell.self, forCellWithReuseIdentifier: JobOptionCollectionViewCell.identifier)

        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                return self?.createJobSection()
            }, configuration: config)
    }
    
    private func createJobSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(13)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        return section
    }
    
    // MARK: - Helpers
    private func createLabel(title: String, isHighlighted: Bool = false) -> UILabel {
        return UILabel().then {
            $0.text = title
            $0.textColor = isHighlighted ? .black : .jumpitGray3
            $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        }
    }
    
    //MARK: -Action
    @objc private func searchButtonTapped() {
        delegate?.didSelectSearchButton()
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SortCategoryView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobOptionCollectionViewCell.identifier, for: indexPath) as? JobOptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = jobOptions[indexPath.item]
        cell.dataBind(with: title, isSelected: selectedJobOptions.contains(title))
        return cell
    }
}

