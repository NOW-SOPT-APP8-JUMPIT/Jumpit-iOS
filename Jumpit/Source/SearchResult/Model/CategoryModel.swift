//
//  CategoryModel.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit

struct CategoryModel {
    let title: String
}

extension CategoryModel{
    static func dummy() -> [CategoryModel] {
        return [
            CategoryModel(title: "직무"),
            CategoryModel(title: "경력"),
            CategoryModel(title: "#태그"),
            CategoryModel(title: "기술스택"),
            CategoryModel(title: "지역")
        ]
    }
}
