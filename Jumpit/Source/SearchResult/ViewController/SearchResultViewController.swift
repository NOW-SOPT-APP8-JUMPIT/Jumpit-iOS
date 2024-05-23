//
//  SearchResultViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit
import Then
import SnapKit
import Moya

final class SearchResultViewController: UIViewController {
    // MARK: - Properties
    var searchKeyword: String?
    private let searchAPI = SearchManager()
    private var selectedJobOptions: [Int] = []
    
    private lazy var customNavigationBarView = CustomNavigationBarView().then {
        $0.delegate = self
        $0.searchBar.text = searchKeyword
    }
    private lazy var searchResultCollectionView = SearchResultCollectionView().then {
        $0.backgroundColor = nil
        $0.delegate = self
    }
    private let emptyResultView = EmptyResultView().then {
        $0.alpha = 0
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
        setLayout()
        
        performSearch()
    }
    
    
    // MARK: - SetLayout
    private func setLayout() {
        [customNavigationBarView, searchResultCollectionView,  emptyResultView].forEach {
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
        emptyResultView.snp.makeConstraints {
            $0.center.equalToSuperview()
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
    
    private func performSearch() {
        guard let keyword = searchKeyword else { return }
        
        // MARK: - 일반 검색 API
        if selectedJobOptions.isEmpty {
            searchAPI.searchPositions(withKeyword: keyword) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let positions):
                        let searchResults = self?.convertPositionsToSearchResults(positions) ?? []
                        self?.updateSearchResults(searchResults)
                    case .failure(let error):
                        self?.handleError(error as! MoyaError)
                    }
                }
            }
        } else {
            // MARK: - 필터 검색 API
            searchAPI.searchPositionsFiltered(withKeyword: keyword, categories: selectedJobOptions) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let positions):
                        let searchResults = self?.convertPositionsToSearchResults(positions) ?? []
                        self?.updateSearchResults(searchResults)
                    case .failure(let error):
                        self?.handleError(error as! MoyaError)
                    }
                }
            }
        }
    }
    
    // MARK: - Helper
    private func convertPositionsToSearchResults(_ positions: [Position]) -> [SearchResultModel] {
        return positions.map { position in
            SearchResultModel(
                enterpriseImage: position.company.image,
                enterpriseName: position.company.name,
                recruitmentNotice: position.title,
                technologyStack: position.skills.map { $0.name }
            )
        }
    }
    private func updateSearchResults(_ searchResults: [SearchResultModel]) {
        if searchResults.isEmpty {
            emptyResultView.alpha = 1
            print("검색 결과가 없습니다.")
        } else {
            emptyResultView.alpha = 0
        }
        searchResultCollectionView.updateSearchResults(with: searchResults)
    }
    
    private func handleError(_ error: MoyaError) {
        switch error {
        case .jsonMapping(let response), .objectMapping(_, let response):
            if let responseDataString = try? response.mapString() {
                print("JSON/객체 매핑에 실패했습니다, 응답 데이터: \(responseDataString)")
            } else {
                print("JSON/객체 매핑에 실패했으며, 응답 데이터를 파싱하는 데도 실패했습니다")
            }
        case .statusCode(let response):
            print("상태 코드 오류: \(response.statusCode) - \(String(describing: try? response.mapString()))")
        case .underlying(let underlyingError, _):
            if let moyaError = underlyingError as? MoyaError {
                handleError(moyaError)
            } else {
                print("기저 오류: \(underlyingError.localizedDescription)")
            }
        case .parameterEncoding(let error):
            print("매개변수 인코딩 오류: \(error.localizedDescription)")
        default:
            print("기타 MoyaError: \(error.errorDescription ?? "알 수 없는 오류")")
        }
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
        performSearch()
    }
    func searchBarTextDidChange(_ searchText: String) {
        searchKeyword = searchText
        performSearch()
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
        sortCategoryVC.delegate = self
        present(sortCategoryVC, animated: true)
    }
    
    func didSelectSearchResultCell() {
        let VC = DetailViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SearchResultViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            return ModalPresentationController(presentedViewController: presented, presenting: presenting)
        }
}

// MARK: - SortCategoryViewControllerDelegate
extension SearchResultViewController: SortCategoryViewControllerDelegate {
    func didUpdateSelectedJobOptions(_ selectedOptions: Set<Int>) {
        selectedJobOptions = Array(selectedOptions)
        performSearch()
    }
}
