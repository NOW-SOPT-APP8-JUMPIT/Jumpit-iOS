//
//  JumpitBaseApi.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

// MARK: - Domain
enum MovieOpenDomain {
    case resumes
    case positions
}

extension MovieOpenDomain {
    var url: String {
        switch self {
        case .resumes:
            return "/resumes"
        case .positions:
            return "/positions"
        }
    }
}

protocol MovieOpenAPI: TargetType {
    var domain: MovieOpenDomain { get }
    var urlPath: String { get }
    var error: [Int: NetworkError]? { get }
}

extension MovieOpenAPI {
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
