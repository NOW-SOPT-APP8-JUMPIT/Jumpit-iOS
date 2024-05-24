//
//  ResumeManager.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import Foundation

import Moya


final class ResumeManager {
    private let provider = NetworkProvider<ResumesAPI>()
    
    func getMyResume(userId: Int, completion: @escaping (Result<[Resume], Error>) -> Void) {
        provider.request(api: .fetchMyResume(userId: userId)) { result in
            switch result {
            case let .success(response):
                do {
                    let myResumeResponse = try response.map(RetriveResumeResponse.self)
                    let resumes = myResumeResponse.data.resumes.compactMap { $0 }
                    completion(.success(resumes))
                }
                catch {
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
