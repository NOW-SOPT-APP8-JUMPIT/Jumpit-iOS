//
//  JumpitAPI.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

enum PositionsAPI {
    case searchPositions(keyword: String)
    case searchPositionsFiltered(keyword: String, categories: [Int])
    case fetchPositionDetail(positionId: String)
}

extension PositionsAPI: TargetType, JumpitAPIEndpoint {
    var domain: JumpitAPIDomain {
        return .positions
    }
    
    var urlPath: String {
        switch self {
        case .searchPositions:
            return ""
        case .searchPositionsFiltered:
            return "/filter"
        case .fetchPositionDetail(let positionId):
            return "/\(positionId)"
        }
    }
    
    var error: [Int : NetworkError]? {
        return nil
    }
    
    
    
    var method: Moya.Method {
        switch self {
        case .searchPositions, .searchPositionsFiltered, .fetchPositionDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchPositions(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .searchPositionsFiltered(let keyword, let categories):
            var parameters: [String: Any] = ["keyword": keyword]
            parameters["categories"] = categories
            return .requestParameters(parameters: parameters, encoding: CustomArrayEncoding.default)
        case .fetchPositionDetail:
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
