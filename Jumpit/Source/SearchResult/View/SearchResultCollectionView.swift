//
//  SearchResultCollectionView.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import SnapKit

protocol SearchResultCollectionViewDelegate: AnyObject {
    func didSelectCategoryCell()
    func didSelectSearchResultCell(at indexPath: IndexPath)
}

final class SearchResultCollectionView: UIView {
    // MARK: - Properties
    weak var delegate: SearchResultCollectionViewDelegate?
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout())
    
    private var categoryData = CategoryModel.dummy()
    private var searchResultData = [SearchResultModel]()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetLayout
    private func setLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Action
    func updateSearchResults(with newResults: [SearchResultModel]) {
        searchResultData = newResults
        collectionView.reloadData()
    }
    func getCell(at indexPath: IndexPath) -> SearchResultCollectionViewCell? {
        return collectionView.cellForItem(at: indexPath) as? SearchResultCollectionViewCell
    }
    
    // MARK: - SetupCollectionView
    private func setupCollectionView() {
        collectionView.register(SortCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SortCategoryCollectionViewCell.identifier)
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.register(SearchResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderView.identifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                guard let section = SearchResultViewSection(rawValue: sectionIndex) else { return nil }
                switch section {
                case .sortCategory:
                    return self?.createCategorySection()
                case .searchResult:
                    return self?.createSearchResultSection()
                }
            }, configuration: config)
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(34))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(34))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 6
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        return section
    }
    
    private func createSearchResultSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(113))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(113))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(64))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchResultCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categoryData.count
        case 1:
            return searchResultData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCategoryCollectionViewCell.identifier, for: indexPath) as? SortCategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(categoryData[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(searchResultData[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch SearchResultViewSection(rawValue: indexPath.section) {
        case .searchResult:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.identifier, for: indexPath) as? SearchResultHeaderView else {
                return UICollectionReusableView()
            }
            headerView.dataBind(searchResultData.count)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                delegate?.didSelectCategoryCell()
            }
        case 1:
            delegate?.didSelectSearchResultCell(at: indexPath)
        default:
            break
        }
    }
}
