//
//  RecentSearchView.swift
//  Jumpit
//
//  Created by 정민지 on 5/15/24.
//

import UIKit
import Then
import SnapKit

protocol RecentSearchViewDelegate: AnyObject {
    func didSelectKeyword(_ keyword: String)
}

final class RecentSearchView: UIView {
    // MARK: - Properties
    weak var delegate: RecentSearchViewDelegate?
    private var recentSearchKeywords: [String] = []
    private var tableViewHeightConstraint: Constraint?
    
    private let recentSearchesLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }
    private lazy var allCancelButton = UIButton().then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.jumpitGray4, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(clearRecentSearches), for: .touchUpInside)
    }
    private lazy var recentSearchesTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
    }
    private let searchBannerImageView = UIImageView().then {
        $0.image = .imgSearchBanner
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        updateRecentSearches()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [recentSearchesLabel, allCancelButton, recentSearchesTableView, searchBannerImageView].forEach {
            self.addSubview($0)
        }
        recentSearchesLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalToSuperview().offset(16)
        }
        allCancelButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchesLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(15)
        }
        recentSearchesTableView.snp.makeConstraints { make in
            make.top.equalTo(allCancelButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(12)
            tableViewHeightConstraint = make.height.equalTo(0).constraint
        }
    }
    
    
    // MARK: - Action
    @objc private func clearRecentSearches() {
        RecentSearchModel.shared.clearSearches()
        updateRecentSearches()
    }
    func updateRecentSearches() {
        recentSearchKeywords = RecentSearchModel.shared.searches
        recentSearchesTableView.reloadData()
        updateTableViewHeight()
    }
    private func updateTableViewHeight() {
        let tableHeight = recentSearchKeywords.count * 36
        tableViewHeightConstraint?.update(offset: tableHeight)
        
        if recentSearchKeywords.isEmpty {
            searchBannerImageView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(17)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(75)
            }
        } else {
            searchBannerImageView.snp.remakeConstraints {
                $0.top.equalTo(recentSearchesTableView.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(75)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension RecentSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = recentSearchKeywords[indexPath.row]
        delegate?.didSelectKeyword(keyword)
    }
}

// MARK: - UITableViewDataSource
extension RecentSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchKeywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as? RecentSearchTableViewCell else {  fatalError("셀 타입 캐스팅 실패...") }
        cell.dataBind(recentSearchKeywords[indexPath.row])
        cell.onDelete = { [weak self] in
            self?.updateRecentSearches()
        }
        return cell
    }
}
