//
//  SelectedJobOptionsModel.swift
//  Jumpit
//
//  Created by 정민지 on 5/17/24.
//

import Foundation

class SelectedJobOptionsModel {
    static let shared = SelectedJobOptionsModel()
    
    private init() {}
    
    private(set) var selectedOptions: Set<String> = []
    
    let jobOptions: [String] = [
            "서버/백엔드 개발자",
            "프론트엔드 개발자",
            "웹 풀스택 개발자",
            "안드로이드 개발자",
            "iOS 개발자",
            "크로스플랫폼 앱개발자",
            "게임 클라이언트 개발자",
            "게임 서버 개발자",
            "DBA",
            "빅데이터 엔지니어",
            "인공지능/머신러닝",
            "devops/시스템 엔지니어",
            "정보보안 담당자",
            "QA 엔지니어",
            "개발 PM",
            "HW/임베디드",
            "SW/솔루션",
            "웹퍼블리셔",
            "VR/AR/3D",
            "블록체인",
            "기술지원"
    ]
    
    func addOption(_ option: String) {
        selectedOptions.insert(option)
    }
    
    func removeOption(_ option: String) {
        selectedOptions.remove(option)
    }
    
    func clearOptions() {
        selectedOptions.removeAll()
    }
}
