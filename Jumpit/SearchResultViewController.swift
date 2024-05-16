//
//  SearchResultViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import Then
import SnapKit

final class SearchResultViewController: UIViewController {
    // MARK: - Properties
    var searchKeyword: String?
    
    private lazy var customNavigationBarView = CustomNavigationBarView().then {
        $0.delegate = self
        $0.searchBar.text = searchKeyword
    }
    private lazy var searchResultCollectionView = SearchResultCollectionView().then {
        $0.delegate = self
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
        setLayout()
    }
    
    // MARK: - SetLayout
    private func setLayout() {
        [customNavigationBarView, searchResultCollectionView].forEach {
            self.view.addSubview($0)
        }
        
        customNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63)
        }
        searchResultCollectionView .snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(20)
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
        searchKeyword = keyword
        customNavigationBarView.searchBar.text = keyword
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

// MARK: - SearchResultCollectionViewDelegate
extension SearchResultViewController: SearchResultCollectionViewDelegate {
    func didSelectCategoryCell() {
        let sortCategoryVC = SortCategoryViewController()
        sortCategoryVC.modalPresentationStyle = .custom
        sortCategoryVC.transitioningDelegate = self
        present(sortCategoryVC, animated: true)
    }
    
    func didSelectSearchResultCell() {
        let VC = ViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SearchResultViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            return ModalPresentationController(presentedViewController: presented, presenting: presenting)
        }
}
