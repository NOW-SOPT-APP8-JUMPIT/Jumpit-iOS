//
//  DetailModel.swift
//  Jumpit
//
//  Created by 이지훈 on 5/13/24.
//
import UIKit

struct JobDetail: Hashable {
    var image: UIImage?
    var title: String
    var description: String
    var careerLabel: String
    var educationLabel: String
    var deadlineLabel: String
    var locationLabel: String
    var career: String
    var education: String
    var deadline: String
    var location: String
}

struct ExpandableJobDetail: Hashable {
    var isExpanded: Bool
    let titles: [String]
    let jobDetail: String

  
}

struct DifferentJobDetail: Hashable {
    var title: String
}

struct CompanyInfo: Hashable {
    var image: UIImage?
    var title: String
    var info: String
    var like: Bool
}

struct PositionDetail: Hashable {
    let id: UUID = UUID()
    var image: UIImage?
    var title: String
    var subtitle: String
    var description: String
    var isBookmarked: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: PositionDetail, rhs: PositionDetail) -> Bool {
        return lhs.id == rhs.id
    }
}

struct RewardDetail: Hashable {
    var image: UIImage?
}

enum JobDescriptionSection {
    case jobDetail([JobDetail])
    case expandable([ExpandableJobDetail])
    case differentJobDetail([DifferentJobDetail])
    case companyInfo([CompanyInfo])
    case positionDetail([PositionDetail])
}

enum Section: Int, CaseIterable {
    case jobDetail
    case expandable
    case differentJobDetail
    case companyInfo
    case positionDetail
    case rewardDetail
}

// Mock 데이터 설정
enum MockData {
    static let jobDetails: [JobDetail] = [
        JobDetail(
            image: UIImage(named: "toss"),
            title: "[토스뱅크] Frontend Developer",
            description: "토스뱅크",
            careerLabel: "경력",
            educationLabel: "학력",
            deadlineLabel: "마감일",
            locationLabel: "근무지",
            career: "너만오면 고",
            education: "4학년1학기부터 바로뽑기",
            deadline: "상시모집",
            location: "건국대학교 산학협력관 211호"
        )
    ]
    static let expandableDetails: [ExpandableJobDetail] = [
        ExpandableJobDetail(
            isExpanded: false,
            titles: ["기술스택"],
            jobDetail: "이미지와 타이틀이들어감"
        ),
        ExpandableJobDetail(
            isExpanded: false,
            titles: ["주요업무"],
            jobDetail: "웹뷰망해라 스위프트가 세상을 지배한다"
        ),
        ExpandableJobDetail(
            isExpanded: false,
            titles: ["자격요건"],
            jobDetail: "토스 저좀 뽑아주세요"
        ),
        ExpandableJobDetail(
           isExpanded: false,
            titles: ["우대사항"],
            jobDetail: "긴문자토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요토스 저좀 뽑아주세요"
        ),
        ExpandableJobDetail(
          isExpanded: false,
            titles: ["혜택 및 복지"],
            jobDetail: "문자토스 저좀 뽑아주세요"
        ),
        ExpandableJobDetail(
          isExpanded: false,
            titles: ["채용절차 및 기타"],
            jobDetail: "코테"
        )
    ]
    static let differentJobDetails: [DifferentJobDetail] = [
        DifferentJobDetail(
            title: "합격자 이력서, 내 이력서와 다른점은?!"
        )
    ]
    static let companyInfo: [CompanyInfo] = [
        CompanyInfo(
            image: UIImage(named: "toss"),
            title: "회사 소개",
            info: "기업정보 보기",
            like: true
        )
    ]
    static let positionDetails = [
        PositionDetail(
            image: UIImage(named: "toss"),
            title: "엠비아이솔루션",
            subtitle: "[파이썬] 웹 백엔드 개발자",
            description: "react, Type Script, Swift, Kotlin",
            isBookmarked: true
        ),
        PositionDetail(
            image: UIImage(named: "toss"),
            title: "엠비아이솔루션",
            subtitle: "[파이썬] 웹 백엔드 개발자",
            description: "react, Type Script, Swift, Kotlin",
            isBookmarked: true
        )
    ]
    static let rewardDetails: [RewardDetail] = [
        RewardDetail(image: UIImage(named: "img_detail_reward"))
    ]
}
