//
//  NetworkError.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation

import Moya

enum NetworkError: Int {
    case invalidRequest = 400
}

struct HandleNetworkError {
    static func handleNetworkError(_ error: Error) {
        if let moyaError = error as? MoyaError {
            if let statusCode = moyaError.response?.statusCode {
                let networkError = NetworkError(rawValue: statusCode)
                switch networkError {
                case .invalidRequest:
                    print("잘못된 요청입니다.")
                default:
                    print("서버 에러, 관리자에게 문의하세요.")
                }
            }
        }
    }
}

