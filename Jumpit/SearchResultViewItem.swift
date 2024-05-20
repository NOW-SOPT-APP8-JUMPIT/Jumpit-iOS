//
//  SearchResultViewItem.swift
//  Jumpit
//
//  Created by 정민지 on 5/16/24.
//

import UIKit

enum SearchResultViewSection: Int {
    case sortCategory = 0
    case searchResult = 1
}

enum SearchResultViewItem {
    case sortCategory(CategoryModel)
    case searchResult(SearchResultModel)
}
