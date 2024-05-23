//  SortCategoryViewController.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import UIKit
import Then
import SnapKit

protocol SortCategoryViewControllerDelegate: AnyObject {
    func didUpdateSelectedJobOptions(_ selectedOptions: Set<Int>)
}

final class SortCategoryViewController: UIViewController {
    // MARK: - Properties
    weak var delegate: SortCategoryViewControllerDelegate?
    
    private lazy var sortCategoryView = SortCategoryView().then {
        $0.delegate = self
    }
    private var jobOptions: [String] {
        return SelectedJobOptionsModel.shared.jobOptions
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
        let selectedJobOptionIndices = selectedJobOptions.compactMap { jobOptions.firstIndex(of: $0) }.map { $0 + 1 }
        let selectedOptions = Set(selectedJobOptionIndices)
        delegate?.didUpdateSelectedJobOptions(selectedOptions)
        dismiss(animated: true, completion: nil)
    }
}
