//
//  RetriveResumeResponseDTO.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import Foundation


struct RetriveResumeResponse: Codable {
    let status: Int
    let message: String
    let data: Resumes
}

struct Resumes: Codable {
    let userId: Int
    let resumes: [Resume]
}

struct Resume: Codable {
    let id: Int
    let title: String
    let isPrivate: Bool
}
