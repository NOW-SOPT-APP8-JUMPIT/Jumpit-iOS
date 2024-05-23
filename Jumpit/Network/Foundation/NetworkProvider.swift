//
//  NewworkProvider.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

final class NetworkProvider<API: JumpitAPIEndpoint> where API: TargetType {
    
    private let provider: MoyaProvider<API>
    
    // 제대로 요청했는지 확인하기 위해 -> URL 로그 출력
    private var endpointClosure = { (target: API) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    init(plugins: [PluginType] = []) {
        self.provider = MoyaProvider<API>(endpointClosure: endpointClosure, plugins: plugins)
    }
    
    func request(api: API, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        provider.request(api) { result in
            switch result {
            case let .success(response):
                let requestUrl = response.request?.url?.absoluteString ?? "URL not available"
                print("SUCCESS: \(requestUrl) (\(response.statusCode)) 이 떳다 민지야 잘했어!")
                completion(.success(response))
                
            case let .failure(error):
                let requestUrl = error.response?.request?.url?.absoluteString ?? "URL not available"
                print("ERROR: \(requestUrl) 가 떳다 민지야 수정하자")
                completion(.failure(error))
            }
        }
    }
}
