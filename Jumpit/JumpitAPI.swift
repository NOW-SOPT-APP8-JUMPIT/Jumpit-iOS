//
//  JumpitAPI.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

enum JumpitAPI {
    case postResume(data: ResumeData)
    case fetchMyResume(userId: String)
    case toggleResumePrivacy(resumeId: String)
    case searchPositions(keyword: String)
    case searchPositionsFiltered(keyword: String, categories: [Int])
    case fetchPositionDetail(positionId: String)
}

extension JumpitAPI: JumpitBaseAPI {
    var domain: JumpitAPIDomain {
            return .resumes
        }
    }

    var path: String {
        switch self {
        case .postResume:
            return ""
        case .fetchMyResume(let userId):
            return "/\(userId)"
        case .toggleResumePrivacy(let resumeId):
            return "/\(resumeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postResume:
            return .post
        case .fetchMyResume, .searchPositions, .searchPositionsFiltered, .fetchPositionDetail:
            return .get
        case .toggleResumePrivacy:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case .postResume(let data):
            return .requestJSONEncodable(data)
        case .fetchMyResume, .fetchPositionDetail, .toggleResumePrivacy:
            return .requestPlain
        case .searchPositions(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .searchPositionsFiltered(let keyword, let categories):
            return .requestParameters(parameters: ["keyword": keyword, "categories": categories], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
