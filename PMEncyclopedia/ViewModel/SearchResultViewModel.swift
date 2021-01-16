//
//  SearchResultViewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import Foundation

struct SearchResultViewModel {
    
    var searchText: String?
    var searchResult: Pokemon?

    init(searchText: String?, searchResult: Pokemon?) {
        self.searchText = searchText
        self.searchResult = searchResult
    }
}
