//
//  SearchVIewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import Foundation

struct SearchViewModel {
    
    var searchText: String = ""
    var pokemons: Pokemons?
    
    init(pokemons: Pokemons?) {
        self.pokemons = pokemons
    }
}
