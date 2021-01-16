//
//  Model.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/16.
//

import Foundation

// MARK: - Pokemons
struct Pokemons: Codable {
    let pokemons: [Pokemon]
}

struct Pokemon: Codable {
    let id: Int
    let names: [String]
}

// MARK: - Pokemons
