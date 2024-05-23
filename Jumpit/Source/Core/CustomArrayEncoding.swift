//
//  CustomArrayEncoding.swift
//  Jumpit
//
//  Created by 정민지 on 5/24/24.
//

import Foundation
import Alamofire

struct CustomArrayEncoding: ParameterEncoding {
    public static var `default`: CustomArrayEncoding { return CustomArrayEncoding() }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let url = urlRequest.url else { return urlRequest }
        guard let parameters = parameters else { return urlRequest }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = urlComponents?.queryItems ?? []
        
        for (key, value) in parameters {
            if let array = value as? [Any] {
                for item in array {
                    let queryItem = URLQueryItem(name: key, value: "\(item)")
                    queryItems.append(queryItem)
                }
            } else {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
        }
        
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
        
        return urlRequest
    }
}
