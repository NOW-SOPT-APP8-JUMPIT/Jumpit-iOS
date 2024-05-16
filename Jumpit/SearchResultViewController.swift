//
//  SearchResultViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import Then
import SnapKit

class SearchResultViewController: UIViewController {
    // MARK: - Properties
    private lazy var customNavigationBarView = CustomNavigationBarView().then {
        $0.delegate = self
    }
    private var searchResultView = SearchResultView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
        configureSubviews()
        makeConstraints()
    }
    
    // MARK: - configureSubviews
    private func configureSubviews() {
        [ customNavigationBarView, searchResultView ].forEach {
            self.view.addSubview($0)
        }
    }
    
    // MARK: - makeConstraints
    private func makeConstraints() {
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63)
        }
        searchResultView .snp.makeConstraints {
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
extension SearchResultViewController: CustomNavigationBarDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSearch(keyword: String) {
        saveRecentSearch(keyword: keyword)
    }

    private func saveRecentSearch(keyword: String) {
        var searches = UserDefaults.standard.array(forKey: "recentSearchKeywords") as? [String] ?? []
        if !searches.contains(keyword) {
            searches.insert(keyword, at: 0)
            if searches.count > 5 {
                searches.removeLast()
            }
            UserDefaults.standard.set(searches, forKey: "recentSearchKeywords")
        }
    }
}
