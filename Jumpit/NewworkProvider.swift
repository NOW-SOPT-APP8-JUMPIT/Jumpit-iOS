//
//  NewworkProvider.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation
import Moya

final class NetworkProvider<API: JumpitAPIEndpoint> {
    
    private let provider: MoyaProvider<API>
    
    init(plugins: [PluginType] = []) {
        self.provider = MoyaProvider(plugins: plugins)
    }
    
    func request(api: API, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        let requestString = "\(api.urlPath)"
        
        provider.request(api) { result in
            switch result {
            case let .success(response):
                print("SUCCESS: \(requestString) (\(response.statusCode)) 이 떳다 민지야 잘했어!")
                completion(.success(response))
                
            case let .failure(error):
                print("ERROR: \(requestString) 가 떳다 민지야 수정하자")
                completion(.failure(error))
            }
        }
    }
}