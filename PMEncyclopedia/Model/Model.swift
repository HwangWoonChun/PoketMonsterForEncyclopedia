//
//  Model.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/16.
//

import Foundation

// MARK: - Pokemons
struct Pokemons: Codable {
    let pokemons: [Pokemon]?
}

struct Pokemon: Codable {
    let id: Int?
    let names: [String]?
}

// MARK: - PokemonInfo
struct PokemonInfo: Codable {
    let height: Int?
    let id: Int?
    let sprites: Sprites?
    let weight: Int?
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - Welcome
struct Locations: Codable {
    let locations: [Location]?
    
    enum CodingKeys: String, CodingKey {
        case locations = "pokemons"
    }
}

// MARK: - Pokemon
struct Location: Codable {
    let lat, lng: Double?
    let id: Int?
}
