//
//  InfoVIewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import Foundation

struct InfoViewModel {
    
    let name: [String]?
    let pokemon: PokemonInfo?
    let imageURL: String?
    let locations: [Location]?
    let isHaveLocation: Bool?

    init(name: [String]?, pokemon: PokemonInfo?, locations: [Location]?) {
        self.name = name
        self.pokemon = pokemon
        self.locations = locations
        self.isHaveLocation = (self.locations?.count ?? 0) > 0 ? true : false
        let sprite = pokemon?.sprites
        var url = ""
        //frontDefault 우선 - 요구사항 2-c
        if let frontDefault = sprite?.frontDefault {
            url = frontDefault
        } else {
            if let backDefault = sprite?.backDefault { url =  backDefault }
            if let backFemale = sprite?.backFemale { url =  backFemale }
            if let backShiny = sprite?.backShiny { url =  backShiny }
            if let backShinyFemale = sprite?.backShinyFemale { url =  backShinyFemale }
            if let frontFemale = sprite?.frontFemale { url =  frontFemale }
            if let frontShiny = sprite?.frontShiny { url =  frontShiny }
            if let frontShinyFemale = sprite?.frontShinyFemale { url =  frontShinyFemale }
            if let otherFrontDefault = sprite?.other?.dreamWorld?.frontDefault { url =  otherFrontDefault }
            if let otherFrontFemale = sprite?.other?.dreamWorld?.frontFemale { url =  otherFrontFemale }
            if let otherArtWorkFrontDefault = sprite?.other?.officialArtwork?.frontDefault { url =  otherArtWorkFrontDefault }
            if let otherArtWorkFrontFemail = sprite?.other?.officialArtwork?.frontFemale { url =  otherArtWorkFrontFemail }
        }
        self.imageURL = url
    }
}
