//
//  SearchResultViewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import Foundation

struct SearchResultViewModel {
    
    let searchText: String?
    let searchResult: Pokemon?

    init(searchText: String?, searchResult: Pokemon?) {
        self.searchText = searchText
        self.searchResult = searchResult
    }
    
}
