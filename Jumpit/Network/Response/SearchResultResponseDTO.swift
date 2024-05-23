//
//  SearchResultResponseDTO.swift
//  Jumpit
//
//  Created by 정민지 on 5/24/24.
//

import Foundation
import Moya

struct SearchResultResponse: Codable {
    let status: Int
    let message: String
    let data: PositionData?
}

struct PositionData: Codable {
    let position: [Position?]?
}

struct Position: Codable {
    let company: Company
    let id: Int
    let title: String
    let skills: [Skill]
}

struct Company: Codable {
    let id: Int
    let name: String
    let image: String
    let description: String
}

struct Skill: Codable {
    let name: String
    let image: String
}
