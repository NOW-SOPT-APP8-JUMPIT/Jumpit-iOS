//
//  ResumeDataPostResponseDTO.swift
//  Jumpit
//
//  Created by 이지훈 on 5/24/24.
//

import Foundation

struct ResumeDataPostResponse: Codable {
    let status: Int
    let message: String
    let data: Data?
}
