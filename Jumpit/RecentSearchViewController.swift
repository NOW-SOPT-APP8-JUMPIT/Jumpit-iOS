//
//  RecentSearchViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/15/24.
//

import UIKit
import Then
import SnapKit

class RecentSearchViewController: UIViewController {
    // MARK: - Properties
    private lazy var customNavigationBarView = CustomNavigationBarView().then {
        $0.delegate = self
    }
    private var recentSearchView = RecentSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
        configureSubviews()
        makeConstraints()
    }
    
    // MARK: - configureSubviews
    private func configureSubviews() {
        [ customNavigationBarView, recentSearchView ].forEach {
            self.view.addSubview($0)
        }
    }
    
    // MARK: - makeConstraints
    private func makeConstraints() {
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
    }
}
