//
//  RecentSearchModel.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import Foundation

class RecentSearchModel {
    static let shared = RecentSearchModel()
    private let maxCount = 5
    private let defaultsKey = "recentSearchKeywords"
    
    var searches: [String] {
        get {
            return UserDefaults.standard.array(forKey: defaultsKey) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: defaultsKey)
        }
    }

    func addSearch(keyword: String) {
        var updatedSearches = searches.filter { $0 != keyword }
        updatedSearches.insert(keyword, at: 0)
        if updatedSearches.count > maxCount {
            updatedSearches.removeLast()
        }
        searches = updatedSearches
    }
    
    func removeSearch(keyword: String) {
        if let index = searches.firstIndex(of: keyword) {
            searches.remove(at: index)
        }
    }

    
    func clearSearches() {
        searches = []
    }
}
