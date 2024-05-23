//
//  JumpitBaseApi.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//
import Foundation
import Moya

// MARK: - Domain
protocol JumpitAPIEndpoint: TargetType {
    var path: String { get }
    var error: [Int: NetworkError]? { get }
}

extension JumpitAPIEndpoint {
    var baseURL: URL {
        return URL(string: PrivacyInfoManager.baseURL)!
    }

    
    var validationType: ValidationType {
        return .successCodes
    }
}
