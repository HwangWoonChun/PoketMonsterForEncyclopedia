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

    init(name: [String]?, pokemon: PokemonInfo?, locations: [Location]?) {
        self.name = name
        self.pokemon = pokemon
        self.locations = locations
        let sprite = pokemon?.sprites
        var url = ""
        if let backDefault = sprite?.backDefault { url =  backDefault }
        if let backFemale = sprite?.backFemale { url =  backFemale }
        if let back_shiny = sprite?.backShiny { url =  back_shiny }
        if let back_shiny_female = sprite?.backShinyFemale { url =  back_shiny_female }
        if let front_default = sprite?.frontDefault { url =  front_default }
        if let front_female = sprite?.frontFemale { url =  front_female }
        if let front_shiny = sprite?.frontShiny { url =  front_shiny }
        if let front_shiny_female = sprite?.frontShinyFemale { url =  front_shiny_female }
        if let otherFrontDefault = sprite?.other?.dreamWorld?.frontDefault { url =  otherFrontDefault }
        if let otherFrontFemale = sprite?.other?.dreamWorld?.frontFemale { url =  otherFrontFemale }
        if let otherArtWorkFrontDefault = sprite?.other?.officialArtwork?.frontDefault { url =  otherArtWorkFrontDefault }
        if let otherArtWorkFrontFemail = sprite?.other?.officialArtwork?.frontFemale { url =  otherArtWorkFrontFemail }
        self.imageURL = url
    }
}
