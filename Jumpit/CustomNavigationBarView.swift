//
//  CustomNavigationBarView.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import Then
import SnapKit

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapBackButton()
    func didSearch(keyword: String)
}

final class CustomNavigationBarView: UIView {
    // MARK: - Properties
    weak var delegate: CustomNavigationBarDelegate?
    
    private var navigationBarView = UIView().then {
        $0.backgroundColor = .white
    }
    private lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_back"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        $0.tintColor = .black
    }
    lazy var searchBar = UISearchBar().then {
        $0.placeholder = "‘Python’을 검색해보세요"
        $0.backgroundColor = .jumpitGray1
        $0.layer.cornerRadius = 52/2
        
        
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        
        let textField = $0.searchTextField
        textField.textColor = .black
        
        if let leftView = textField.leftView as? UIImageView {
            leftView.image = UIImage(named: "icn_search")
            leftView.tintColor = .black
        }
        
        $0.tintColor = .black
        $0.isUserInteractionEnabled = true
        $0.delegate = self
    }
    
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
        self.addSubview(navigationBarView)
        [backButton, searchBar].forEach {
            navigationBarView.addSubview($0)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(63)
        }
        backButton.snp.makeConstraints {
            $0.leading.equalTo(navigationBarView.snp.leading).offset(6)
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.height.width.equalTo(44)
        }
        searchBar.snp.makeConstraints {
            $0.bottom.equalTo(navigationBarView.snp.bottom)
            $0.leading.equalTo(backButton.snp.trailing).offset(3)
            $0.trailing.equalTo(navigationBarView.snp.trailing).inset(22)
            $0.height.equalTo(52)
        }
    }
    
    
    // MARK: - Action
    @objc private func backButtonTapped() {
        delegate?.didTapBackButton()
    }
}



// MARK: - UISearchBarDelegate
extension CustomNavigationBarView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            RecentSearchModel.shared.addSearch(keyword: searchText)
            searchBar.resignFirstResponder()
            delegate?.didSearch(keyword: searchText)
        }
    }
}
