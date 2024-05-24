//
//  HomeViewController.swift
//  Jumpit
//
//  Created by YOUJIM on 5/16/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private let themeData = ImageModel.themes()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = UIView()
    
    private lazy var searchButton: HomeSearchButton = HomeSearchButton().then {
        $0.addTarget(self, action: #selector(didSearchButtonTapped), for: .touchUpInside)
    }
    
    private let jobLabel: UILabel = UILabel().then {
        $0.text = "직무별로 보기"
        $0.textColor = .black
        $0.font = CustomFont.subTitle01
    }
    
    private let iosJobView: JobView = JobView().then {
        $0.bindData("iOS 개발\n자", .icnIosfront)
    }
    
    private let backJobView: JobView = JobView().then {
        $0.bindData("서버/백엔\n드 개발자", .icnServerback)
    }
    
    private let webJobView: JobView = JobView().then {
        $0.bindData("웹 풀스택\n개발자", .icnWebfull)
    }
    
    private let swJobView: JobView = JobView().then {
        $0.bindData("SW/\n솔루션", .icnSwsol)
    }
    
    private let aiJobView: JobView = JobView().then {
        $0.bindData("인공지능/\n머신러닝", .icnAiml)
    }
    
    private let qaJobView: JobView = JobView().then {
        $0.bindData("QA\n엔지니어", .icnQa)
    }
    
    private let aosJobView: JobView = JobView().then {
        $0.bindData("안드로이드\n개발자", .icnAndroid)
    }
    
    private let allJobView: JobView = JobView().then {
        $0.bindData("직무\n전체보기", .icnJaball)
    }
    
    private let themeLabel: UILabel = UILabel().then {
        $0.text = "테마별 모음 .zip"
        $0.textColor = .black
        $0.font = CustomFont.subTitle01
    }
    
    private lazy var themeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 13
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: ThemeCollectionViewCell.cellID)
    }
    
    private let developerLabel: UILabel = UILabel().then {
        $0.text = "\"개발자에게 꼭 필요한 것만!\""
        $0.textColor = .black
        $0.font = CustomFont.subTitle01
    }
    
    private let feedImageView: UIImageView = UIImageView().then {
        $0.image = .btnFeedIos
        $0.contentMode = .scaleAspectFill
    }
    
    private let qnaImageView: UIImageView = UIImageView().then {
        $0.image = .btnQnaIos
        $0.contentMode = .scaleAspectFill
    }
    
    private let interviewImageView: UIImageView = UIImageView().then {
        $0.image = .btnInterviewIos
        $0.contentMode = .scaleAspectFill
    }
    
    private let contentImageView: UIImageView = UIImageView().then {
        $0.image = .btnContentIos
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var passResumeButton: UIButton = UIButton().then {
        $0.setImage(.btnPassresume.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let bottomLogoImageView: UIImageView = UIImageView().then {
        $0.image = .imgLogoGray
        $0.contentMode = .scaleAspectFill
    }
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setConstraint()
        setDelegate()
    }
    
    
    // MARK: - Functions
    
    private func setLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            searchButton, jobLabel, iosJobView, backJobView, webJobView, swJobView, aiJobView, qaJobView, aosJobView, allJobView, themeLabel, themeCollectionView, developerLabel, feedImageView, qnaImageView, interviewImageView, contentImageView, passResumeButton, bottomLogoImageView
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraint() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(52)
        }
        
        jobLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(15)
        }
        
        iosJobView.snp.makeConstraints {
            $0.top.equalTo(jobLabel.snp.bottom).offset(22)
            $0.leading.equalTo(jobLabel).offset(2)
            $0.width.equalTo(72)
            $0.height.equalTo(80)
        }
        
        backJobView.snp.makeConstraints {
            $0.centerY.width.height.equalTo(iosJobView)
            $0.leading.equalTo(iosJobView.snp.trailing).offset(22)
        }
        
        webJobView.snp.makeConstraints {
            $0.centerY.width.height.equalTo(iosJobView)
            $0.leading.equalTo(backJobView.snp.trailing).offset(22)
        }
        
        swJobView.snp.makeConstraints {
            $0.centerY.width.height.equalTo(iosJobView)
            $0.leading.equalTo(webJobView.snp.trailing).offset(22)
        }
        
        aiJobView.snp.makeConstraints {
            $0.top.equalTo(iosJobView.snp.bottom).offset(24)
            $0.centerX.width.height.equalTo(iosJobView)
        }
        
        qaJobView.snp.makeConstraints {
            $0.centerY.equalTo(aiJobView)
            $0.centerX.width.height.equalTo(backJobView)
        }
        
        aosJobView.snp.makeConstraints {
            $0.centerY.equalTo(aiJobView)
            $0.centerX.width.height.equalTo(webJobView)
        }
        
        allJobView.snp.makeConstraints {
            $0.centerY.equalTo(aiJobView)
            $0.centerX.width.height.equalTo(swJobView)
        }
        
        themeLabel.snp.makeConstraints {
            $0.top.equalTo(aiJobView.snp.bottom).offset(38)
            $0.leading.equalTo(jobLabel)
        }
        
        themeCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeLabel.snp.bottom).offset(19)
            $0.leading.equalTo(themeLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        developerLabel.snp.makeConstraints {
            $0.top.equalTo(themeCollectionView.snp.bottom).offset(38)
            $0.leading.equalTo(themeLabel)
        }
        
        feedImageView.snp.makeConstraints {
            $0.top.equalTo(developerLabel.snp.bottom).offset(19)
            $0.leading.equalTo(developerLabel)
            $0.trailing.equalTo(view.snp.centerX).offset(-8)
            $0.height.equalTo(113)
        }
        
        qnaImageView.snp.makeConstraints {
            $0.top.equalTo(feedImageView)
            $0.leading.equalTo(view.snp.centerX).offset(8)
            $0.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(feedImageView)
        }
        
        interviewImageView.snp.makeConstraints {
            $0.top.equalTo(feedImageView.snp.bottom).offset(20)
            $0.leading.equalTo(developerLabel)
            $0.width.height.equalTo(feedImageView)
        }
        
        contentImageView.snp.makeConstraints {
            $0.top.equalTo(interviewImageView)
            $0.trailing.equalTo(qnaImageView)
            $0.width.height.equalTo(feedImageView)
        }
        
        passResumeButton.snp.makeConstraints {
            $0.top.equalTo(interviewImageView.snp.bottom).offset(64)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(41)
        }
        
        bottomLogoImageView.snp.makeConstraints {
            $0.top.equalTo(passResumeButton.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(119)
            $0.bottom.equalToSuperview().inset(69)
        }
    }
    
    private func setDelegate() {
        themeCollectionView.dataSource = self
        themeCollectionView.delegate = self
    }
    
    @objc
    private func didSearchButtonTapped() {
        let recentSearchVC = RecentSearchViewController()
        navigationController?.pushViewController(recentSearchVC, animated: true)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let themeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.cellID, for: indexPath) as? ThemeCollectionViewCell else { return UICollectionViewCell() }
        
        return bindThemeData(themeCell, indexPath.row)
    }
    
    func bindThemeData(_ bindCell: ThemeCollectionViewCell, _ path: Int) -> ThemeCollectionViewCell {
        let cell = bindCell
        
        cell.imageView.image = themeData[path].image
        
        return cell
    }
}
