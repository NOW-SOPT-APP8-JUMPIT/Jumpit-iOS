//
//  DetailVC.swift
//  Jumpit
//
//  Created by 이지훈 on 5/13/24.
//
import UIKit

import SnapKit
import Moya


class DetailVC: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var bottomRegisterViewController = BottomRegisterViewController()
    private let networkProvider = NetworkProvider<PositionsAPI>()
    var positionId: String?

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.isHidden = true
        }

      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureCollectionView()
        configureDataSource()
        applyInitialSnapshots()
        addBottomRegisterView()
        fetchPositionDetail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configureCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        
        collectionView.register(JDCVC.self, forCellWithReuseIdentifier: "JDCVC")
        collectionView.register(ExpandableJobCell.self, forCellWithReuseIdentifier: "ExpandableJobCell")
        collectionView.register(DifferenceResumeCollectionViewCell.self, forCellWithReuseIdentifier: "DifferenceResumeCollectionViewCell")
        collectionView.register(CompanyInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CompanyInfoCollectionViewCell")
        collectionView.register(PlaceholderCell.self, forCellWithReuseIdentifier: "PlaceholderCell")
        
        collectionView.register(PositionHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PositionHeaderCollectionViewCell")
        
        collectionView.register(PositionBodyCollectionViewCell.self, forCellWithReuseIdentifier: "PositionBodyCollectionViewCell")
        collectionView.register(rewardCVC.self, forCellWithReuseIdentifier: "rewardCVC")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    
    private func addBottomRegisterView() {
        addChild(bottomRegisterViewController)
        view.addSubview(bottomRegisterViewController.view)
        bottomRegisterViewController.didMove(toParent: self)
        
        bottomRegisterViewController.view.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let sectionType = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            
            switch sectionType {
            case .jobDetail:
                if (item as? String)?.starts(with: "Placeholder_jobDetail_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JDCVC", for: indexPath) as! JDCVC
                if let jobDetail = item as? JobDetail {
                    cell.configure(with: jobDetail)
                }
                return cell
            case .expandable:
                if (item as? String)?.starts(with: "Placeholder_expandable_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandableJobCell", for: indexPath) as! ExpandableJobCell
                if let expandableDetail = item as? ExpandableJobDetail {
                    cell.detail = expandableDetail
                    cell.isExpanded = expandableDetail.isExpanded
                }
                return cell
            case .differentJobDetail:
                if (item as? String)?.starts(with: "Placeholder_differentJobDetail_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DifferenceResumeCollectionViewCell", for: indexPath) as! DifferenceResumeCollectionViewCell
                if let differentDetail = item as? DifferentJobDetail {
                    cell.configure(with: differentDetail.title)
                }
                return cell
            case .companyInfo:
                if (item as? String)?.starts(with: "Placeholder_companyInfo_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyInfoCollectionViewCell", for: indexPath) as! CompanyInfoCollectionViewCell
                if let companyInfo = item as? CompanyInfo {
                    cell.configure(with: companyInfo)
                }
                return cell
            case .positionDetail:
                if (item as? String)?.starts(with: "Placeholder_positionDetail_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PositionBodyCollectionViewCell", for: indexPath) as! PositionBodyCollectionViewCell
                if let detail = item as? PositionDetail {
                    cell.configure(with: detail)
                }
                return cell
            case .rewardDetail:
                if (item as? String)?.starts(with: "Placeholder_rewardDetail_") == true {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rewardCVC", for: indexPath) as! rewardCVC
                if let rewardDetail = item as? RewardDetail {
                    cell.configure(with: rewardDetail.image)
                }
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard let sectionType = Section(rawValue: indexPath.section) else { return nil }
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "PositionHeaderCollectionViewCell",
                    for: indexPath) as? PositionHeaderCollectionViewCell
                
                return header
            }
            return nil
        }
    }


    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .jobDetail:
                return self.getLayoutCompanyInfoSection()
            case .expandable:
                return self.getLayoutExpandableSection()
            case .differentJobDetail:
                return self.getLayoutDifferentJobSection()
            case .companyInfo:
                return self.getLayoutCompanyInfoAndLikeSection()
            case .positionDetail:
                return self.getLayoutForPositionDetail()
            case .rewardDetail:
                return self.getLayoutForRewardDetail()
            }
        }
    }
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.jobDetail, .expandable, .differentJobDetail, .companyInfo, .positionDetail, .rewardDetail])
        
        snapshot.appendItems(MockData.differentJobDetails, toSection: .differentJobDetail)
        snapshot.appendItems(MockData.companyInfo, toSection: .companyInfo)
        snapshot.appendItems(MockData.positionDetails, toSection: .positionDetail)
        snapshot.appendItems(MockData.rewardDetails, toSection: .rewardDetail)

        let jobDetailPlaceholders = Array(0..<5).map { "Placeholder_jobDetail_\($0)" }
        let expandablePlaceholders = Array(0..<5).map { "Placeholder_expandable_\($0)" }
        let differentJobDetailPlaceholders = Array(0..<5).map { "Placeholder_differentJobDetail_\($0)" }
        let companyInfoPlaceholders = Array(0..<5).map { "Placeholder_companyInfo_\($0)" }
        let positionDetailPlaceholders = Array(0..<5).map { "Placeholder_positionDetail_\($0)" }
        let rewardDetailPlaceholders = Array(0..<5).map { "Placeholder_rewardDetail_\($0)" }

        snapshot.appendItems(jobDetailPlaceholders, toSection: .jobDetail)
        snapshot.appendItems(expandablePlaceholders, toSection: .expandable)
        snapshot.appendItems(differentJobDetailPlaceholders, toSection: .differentJobDetail)
        snapshot.appendItems(companyInfoPlaceholders, toSection: .companyInfo)
        snapshot.appendItems(positionDetailPlaceholders, toSection: .positionDetail)
        snapshot.appendItems(rewardDetailPlaceholders, toSection: .rewardDetail)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    //스냅샷 업데이트
    func updateSnapshot(for cell: ExpandableJobCell, at indexPath: IndexPath) {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .expandable)[indexPath.row] as? ExpandableJobDetail {
            print("Updating snapshot for item at indexPath: \(indexPath)")
            snapshot.reloadItems([item])
            dataSource.apply(snapshot, animatingDifferences: true)
        } else {
            print("Item not found in snapshot for update at indexPath: \(indexPath)")
        }
    }

    
    //0번쨰 회사정보
    func getLayoutCompanyInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    //1번째 확장정보 셀
    func getLayoutExpandableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 5

        return section
    }

    
    //2번째 회사가 남들과 다른? 셀
    func getLayoutDifferentJobSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    // 3번째 회사정보 셀
    //해당 셀에서 footer를 사용하지 않고 기본 셀 바닥에 view를 깔아서 셀을 나누었습니다 -> 재활용 할 view가 없어서 푸터를 추가생성하지 않았어요!
    func getLayoutCompanyInfoAndLikeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: -52, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    //4번째 지금유사한 포지션 셀
    func getLayoutForPositionDetail() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.18))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = -30


        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    //5번째 70만원 드려요? 셀
    func getLayoutForRewardDetail() ->
    NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.95))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
  
    
    private func fetchPositionDetail() {
        networkProvider.request(api: .fetchPositionDetail(positionId: positionId ?? "")) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let resturantResponse = try decoder.decode(ResturantResponse.self, from: response.data)
                    
                    guard let data = resturantResponse.data else {
                        return
                    }
                    
                    // Mapping Position and Company to JobDetail
                    let position = data.position
                    let company = data.company
                    
                    self?.loadImage(from: company?.image) { image in
                        let jobDetail = JobDetail(
                            image: image,
                            title: position?.title ?? "",
                            description: company?.description ?? "",
                            careerLabel: "경력",
                            educationLabel: "학력",
                            deadlineLabel: "마감일",
                            locationLabel: "근무지",
                            career: position?.career ?? "",
                            education: position?.education ?? "",
                            deadline: position?.deadline ?? "",
                            location: position?.location ?? ""
                        )
                        
                        // Mapping Skills to ExpandableJobDetail
                        let jobSkills: [JobSkill] = data.skills?.map { JobSkill(name: $0.name, image: $0.image) } ?? []
                        let expandableJobDetails: [ExpandableJobDetail] = [
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["기술스택"],
                                jobDetail: "",
                                skills: jobSkills
                            ),
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["주요업무"],
                                jobDetail: position?.responsibilities ?? "",
                                skills: nil
                            ),
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["자격요건"],
                                jobDetail: position?.qualifications ?? "",
                                skills: nil
                            ),
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["우대사항"],
                                jobDetail: position?.preferred ?? "",
                                skills: nil
                            ),
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["혜택 및 복지"],
                                jobDetail: position?.benefits ?? "",
                                skills: nil
                            ),
                            ExpandableJobDetail(
                                isExpanded: false,
                                titles: ["채용절차 및 기타"],
                                jobDetail: position?.notice ?? "",
                                skills: nil
                            )
                        ]
                        
                        self?.updateUISnapshot(with: jobDetail, expandableJobDetails: expandableJobDetails)
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }

    }

    // PlaceHolder -> 진짜 데이터로 교체
    private func updateUISnapshot(with jobDetail: JobDetail, expandableJobDetails: [ExpandableJobDetail]) {
        var snapshot = dataSource.snapshot()
        
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .jobDetail))
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .expandable))
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .companyInfo))
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .differentJobDetail))
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .rewardDetail))
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .positionDetail))
        
        snapshot.appendItems([jobDetail], toSection: .jobDetail)
        snapshot.appendItems(expandableJobDetails, toSection: .expandable)
        snapshot.appendItems(MockData.companyInfo, toSection: .companyInfo)
        snapshot.appendItems(MockData.differentJobDetails, toSection: .differentJobDetail)
        snapshot.appendItems(MockData.rewardDetails, toSection: .rewardDetail)
        snapshot.appendItems(MockData.positionDetails, toSection: .positionDetail)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }



    private func loadImage(from urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

  
}

extension DetailVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.snapshot().itemIdentifiers(inSection: Section.allCases[section]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("This method shouldn't be called as the data source is provided by the diffable data source.")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionType = Section(rawValue: indexPath.section) else {
            fatalError("Unknown section")
        }
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "PositionHeaderCollectionViewCell",
                for: indexPath) as! PositionHeaderCollectionViewCell
            
            return header
        }
        
        fatalError("Unexpected element kind")
    }
    
}

extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var item = dataSource.itemIdentifier(for: indexPath) as? ExpandableJobDetail else {
            return
        }
        item.isExpanded.toggle()

        var snapshot = dataSource.snapshot()

        // 항목 업데이트
        snapshot.insertItems([item], beforeItem: snapshot.itemIdentifiers(inSection: .expandable)[indexPath.row])
        snapshot.deleteItems([dataSource.itemIdentifier(for: indexPath)!])
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
        collectionView.performBatchUpdates({
            collectionView.layoutIfNeeded()
        }, completion: nil)
    }
}
