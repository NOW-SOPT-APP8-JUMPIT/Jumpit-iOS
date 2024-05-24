//
//  PrivateResumeRequestDTO.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import Foundation


struct PrivateResumeRequest: Codable {
    let isPrivate: Bool
}

struct ResumeDataPostRequest: Codable {
    let title: String
    let userId: Int
}

