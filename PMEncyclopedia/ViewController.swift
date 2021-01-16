//
//  ViewController.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchView: SearchView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.sharedAPI.getPokemonName { (pokemons) in
            let viewModel = SearchViewModel(pokemons: pokemons)
            self.searchView.bind(to: viewModel)
        }
    }
}

