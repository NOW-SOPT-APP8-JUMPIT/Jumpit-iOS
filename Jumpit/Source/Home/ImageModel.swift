//
//  themeModel.swift
//  Jumpit
//
//  Created by YOUJIM on 5/23/24.
//

import Foundation
import UIKit


struct ImageModel {
    let image: UIImage
}


extension ImageModel {
    static func themes() -> [ImageModel] {
        return [
            ImageModel(image: .btnHot),
            ImageModel(image: .btnUnicorn),
            ImageModel(image: .btnRecruiter),
            ImageModel(image: .btnSalary)
        ]
    }
}
