//
//  CompanyDetailResonseDTO.swift
//  Jumpit
//
//  Created by 이지훈 on 5/24/24.
//

import Foundation

// MARK: - ResturantResponse
struct ResturantResponse: Decodable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let position: DetailPosition?
    let company: DetailCompany?
    let skills: [DetailSkill]?
}

// MARK: - Company
struct DetailCompany: Decodable {
    let id: Int?
    let name: String?
    let image: String?
    let description: String?
}

// MARK: - Position
struct DetailPosition: Decodable {
    let id: Int?
    let title, career, education, deadline: String?
    let location, responsibilities, qualifications, preferred: String?
    let benefits, notice: String?
}

// MARK: - Skill
struct DetailSkill: Decodable {
    let name: String?
    let image: String?
}
