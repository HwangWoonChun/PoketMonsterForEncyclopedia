//
//  Service.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/16.
//

import Foundation

struct CommonURL {
    //common
    static let commonDomain: String = "https://demo0928971.mockable.io"
    //API URL
    static let pokemonName: String = "/pokemon_name"
    static let pokemonLocation: String = "/pokemon_locations/"
    static let pokemonDetail: String = "https://pokeapi.co/api/v2/pokemon/"
}

class Network {
    //Base
    static let sharedAPI = Network()
    
    //Auth
    func getPokemonName(completionHandler: @escaping (Pokemons?) -> Void) {

        let requestString = "\(CommonURL.commonDomain)\(CommonURL.pokemonName)"
        guard let serviceUrl = URL(string: requestString) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil)
            }
            do {
                if let data = data {
                    let decoded = try JSONDecoder().decode(Pokemons.self, from: data)
                    completionHandler(decoded)
                } else {
                    completionHandler(nil)
                }
            } catch {
                print(error)
                completionHandler(nil)
            }
        }
        session.resume()
    }
}
