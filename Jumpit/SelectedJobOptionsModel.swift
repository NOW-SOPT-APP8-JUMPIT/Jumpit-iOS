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
