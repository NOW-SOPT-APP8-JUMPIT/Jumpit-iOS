//
//  PrivateResumeResponseDTO.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import Foundation


struct PrivateResumeResponse: Codable {
    let status: Int
    let message: String
}


struct ResumeDataPostResponse: Codable {
    let status: Int
    let message: String
    let data: Data?
}
