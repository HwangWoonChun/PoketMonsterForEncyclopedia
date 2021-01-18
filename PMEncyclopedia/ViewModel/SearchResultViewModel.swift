//
//  SearchResultViewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import Foundation

struct SearchResultViewModel {
    
    //검색어
    let searchText: String?
    //검색결과 cell 정보
    let searchResult: Pokemon?
    let koreanName: String?

    init(searchText: String?, searchResult: Pokemon?) {
        self.searchText = searchText
        self.searchResult = searchResult
        //요구사항 1-b : 검색결과는 한글만 채택
        self.koreanName = searchResult?.names?[0]
    }
    
}
