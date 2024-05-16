//
//  SearchResultModel.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit

struct SearchResultModel {
    let enterpriseImage: String
    let enterpriseName: String
    let recruitmentNotice: String
    let technologyStack: [String]
}

extension SearchResultModel{
    static func dummy() -> [SearchResultModel] {
        return [
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] Frontend Developer",
                technologyStack: ["React", "TypeScript", "Next.js"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] System Engineer",
                technologyStack: ["Linux", "Python", "Shell"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] QA Manager",
                technologyStack: ["Testrail", "Jira", "Notion", "Framer", "Slac", "Notion", "Framer", "Slac"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] Frontend Developer",
                technologyStack: ["React", "TypeScript", "Next.js"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] System Engineer",
                technologyStack: ["Linux", "Python", "Shell"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] QA Manager",
                technologyStack: ["Testrail", "Jira", "Notion", "Framer", "Slac"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] Frontend Developer",
                technologyStack: ["React", "TypeScript", "Next.js"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] System Engineer",
                technologyStack: ["Linux", "Python", "Shell"]
            ),
            SearchResultModel(
                enterpriseImage: "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                enterpriseName: "토스뱅크",
                recruitmentNotice: "[토스뱅크] QA Manager",
                technologyStack: ["Testrail", "Jira", "Notion", "Framer", "Slac"]
            ),
        ]
    }
}
