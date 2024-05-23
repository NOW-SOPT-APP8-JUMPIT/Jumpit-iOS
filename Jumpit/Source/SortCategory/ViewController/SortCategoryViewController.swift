//  SortCategoryViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

final class SortCategoryViewController: UIViewController {
    // MARK: - Properties
    private lazy var sortCategoryView = SortCategoryView().then {
        $0.delegate = self
    }
    private var selectedJobOptions: Set<String> {
        return SelectedJobOptionsModel.shared.selectedOptions
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        modalPresentationStyle = .overCurrentContext
        
        setLayout()

    }
    
    // MARK: - SetLayout
    private func setLayout() {
        view.addSubview(sortCategoryView)
        
        sortCategoryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - SortCategoryViewDelegate
extension SortCategoryViewController: SortCategoryViewDelegate {
    func didSelectSearchButton() {
        print("선택된 버튼들: \(selectedJobOptions.joined(separator: ", "))")
        dismiss(animated: true, completion: nil)
    }
}
