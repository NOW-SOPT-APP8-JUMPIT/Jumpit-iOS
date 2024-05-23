//
//  JumpitManager.swift
//  Jumpit
//
//  Created by 이지훈 on 5/22/24.
//

import Foundation

final class SearchManager {
    private let provider = NetworkProvider<PositionsAPI>()
    
    func searchPositions(
        withKeyword keyword: String,
        completion: @escaping (Result<[Position], Error>) -> Void)
    {
        provider.request(api: .searchPositions(keyword: keyword)) { result in
            switch result {
            case let .success(response):
                do {
                    let apiResponse = try response.map(SearchResultResponse.self)
                    let positions = apiResponse.data?.position?.compactMap { $0 } ?? []
                    completion(.success(positions))
                } catch {
                    print("Error mapping data: \(error)")
                    completion(.failure(error))
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
                completion(.failure(error))
            }
        }
    }
    func searchPositionsFiltered(
        withKeyword keyword: String,
        categories: [Int],
        completion: @escaping (Result<[Position], Error>) -> Void)
    {
        provider.request(api: .searchPositionsFiltered(keyword: keyword, categories: categories)) { result in
            switch result {
            case let .success(response):
                do {
                    let apiResponse = try response.map(SearchResultResponse.self)
                    let positions = apiResponse.data?.position?.compactMap { $0 } ?? []
                    completion(.success(positions))
                } catch {
                    print("Error mapping data: \(error)")
                    completion(.failure(error))
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
                completion(.failure(error))
            }
        }
    }
}
