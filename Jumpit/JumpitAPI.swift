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

extension JumpitAPI: TargetType {
    var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String,
              let url = URL(string: urlString) else {
            fatalError("BaseURL not set in plist for this environment")
        }
        return url
    }

    var path: String {
        switch self {
        case .postResume:
            return "/resumes"
        case .fetchMyResume(let userId):
            return "/resumes/\(userId)"
        case .toggleResumePrivacy(let resumeId):
            return "/resumes/\(resumeId)"
        case .searchPositions, .searchPositionsFiltered:
            return "/positions"
        case .fetchPositionDetail(let positionId):
            return "/positions/\(positionId)"
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

extension JumpitAPI {
    var urlPath: String {
        return baseURL.appendingPathComponent(path).absoluteString
    }
}
