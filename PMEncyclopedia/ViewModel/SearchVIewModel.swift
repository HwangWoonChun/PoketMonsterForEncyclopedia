//
//  SearchVIewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import Foundation

struct SearchViewModel {
    
    var searchText: String = ""
    var searchResult: [Pokemon] = []
    
    let pokemons: Pokemons?
    
    init(pokemons: Pokemons?) {
        self.pokemons = pokemons
    }
    
    func searchPokemon() -> [Pokemon] {
        guard let pokemons = self.pokemons else { return [] }
        let searchList = (pokemons.pokemons ?? []).filter {
            let korean = $0.names?[0] ?? ""
            let english = ($0.names?[1] ?? "").uppercased()
            let search = searchText.uppercased()
            return english.contains(search) || korean.contains(search) ? true : false
        }
        return searchList
    }
}
