//
//  RecentSearchViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/15/24.
//

import UIKit
import Then
import SnapKit

final class RecentSearchViewController: UIViewController {
    // MARK: - Properties
    private lazy var customNavigationBarView = CustomNavigationBarView().then {
        $0.delegate = self
    }
    private lazy var recentSearchView = RecentSearchView().then {
        $0.delegate = self
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentSearchView.updateRecentSearches()
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [customNavigationBarView, recentSearchView].forEach {
            self.view.addSubview($0)
        }
        
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63)
        }
        recentSearchView .snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - setNavigationController
    private func setNavigationController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: -Action
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - CustomNavigationBarDelegate
extension RecentSearchViewController: CustomNavigationBarDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSearch(keyword: String) {
        RecentSearchModel.shared.addSearch(keyword: keyword)
        recentSearchView.updateRecentSearches()
        
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchKeyword = keyword
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

// MARK: - RecentSearchViewDelegate
extension RecentSearchViewController: RecentSearchViewDelegate {
    func didSelectKeyword(_ keyword: String) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchKeyword = keyword
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}
