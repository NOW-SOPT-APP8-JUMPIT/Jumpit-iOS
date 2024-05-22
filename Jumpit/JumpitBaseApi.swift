//
//  JumpitBaseApi.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//
import Foundation
import Moya

// MARK: - Domain
enum JumpitAPIDomain {
    case resumes
    case positions
}

extension JumpitAPIDomain {
    var url: String {
        switch self {
        case .resumes:
            return "/resumes"
        case .positions:
            return "/positions"
        }
    }
}

protocol JumpitAPIEndpoint: TargetType {
    var domain: JumpitAPIDomain { get }
    var urlPath: String { get }
    var error: [Int: NetworkError]? { get }
}

extension JumpitAPIEndpoint {
    var baseURL: URL {
        return URL(string: PrivacyInfoManager.baseURL)!
    }
    
    var path: String {
        return domain.url + urlPath
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
