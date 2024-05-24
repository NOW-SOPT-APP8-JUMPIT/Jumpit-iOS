//
//  JumpitAPI.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

enum ResumesAPI {
    case postResume(data: ResumeData)
    case fetchMyResume(userId: String)
    case toggleResumePrivacy(resumeId: String)
}

extension ResumesAPI: TargetType, JumpitAPIEndpoint {
    var domain: JumpitAPIDomain {
        return .resumes
    }
    
    var urlPath: String {
        switch self {
        case .postResume:
            return ""
        case .fetchMyResume(let userId):
            return "/\(userId)"
        case .toggleResumePrivacy(let resumeId):
            return "/\(resumeId)"
        }
    }
    
    var error: [Int : NetworkError]? {
        return nil
    }

    var method: Moya.Method {
        switch self {
        case .postResume:
            return .post
        case .fetchMyResume:
            return .get
        case .toggleResumePrivacy:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .postResume(let data):
            return .requestJSONEncodable(data)
        case .fetchMyResume, .toggleResumePrivacy:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

