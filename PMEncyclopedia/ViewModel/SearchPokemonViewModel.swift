//
//  SearchVIewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import Foundation

struct SearchViewModel {
    
    //검색어
    var searchText: String = ""
    //검색결과 리스트
    var searchResult: [Pokemon] = []
    //pokemon id, name list
    let pokemons: Pokemons?
    
    init(pokemons: Pokemons?) {
        self.pokemons = pokemons
    }
    //검색결과 리스트 로직
    mutating func searchPokemon(searchText: String) {
        guard let pokemons = self.pokemons else { return }
        let searchList = (pokemons.pokemons ?? []).filter {
            let korean = $0.names?[0] ?? ""
            //요구사항 1-a : 대소문자 구분 하지 않음
            let english = ($0.names?[1] ?? "").uppercased()
            let search = searchText.uppercased()
            return english.contains(search) || korean.contains(search) ? true : false
        }
        self.searchText = searchText
        self.searchResult = searchList
    }
}
