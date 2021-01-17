//
//  ViewController.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchView: SearchView!
    @IBOutlet var tableView: UITableView!
    private var popupView = PokemonInfoView()

    private var locations: [Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.requestService()
    }
    
    private func setup() {
        self.searchView.delegate = self
        self.popupView.delegate = self
        //
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SearchResultCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //
        self.popupView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.popupView.center = view.center
    }
    
    private func requestService() {
        //pokemonList
        Network.sharedAPI.getPokemonName { (pokemons) in
            let viewModel = SearchViewModel(pokemons: pokemons)
            self.searchView.bind(to: viewModel)
        }
        //locationList
        Network.sharedAPI.getPokeLocation { location in
            self.locations = location?.locations ?? []
        }
    }
    
    private func setPopupView(names: [String]?, info: PokemonInfo?, location: [Location]?) {
        DispatchQueue.main.async {
            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.view.addSubview(self.popupView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                let viewModel = InfoViewModel(name: names, pokemon: info, locations: location)
                self.popupView.bind(to: viewModel)
                self.popupView.transform = .identity
            })
        }
    }
}

extension ViewController: SearchViewDelegate {
    func endSearch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: PokemonInfoViewDelegate {
    func moveToMap(locations: [Location]?) {
        guard let locations = locations else { return }
        if locations.count == 0 { return }
        if var detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let viewModel = LocationViewModel(locations: locations)
            detailVC.bind(to: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.searchView.viewModel else { return 0 }
        return viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier:"SearchResultCell", for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        
        let searchResult = self.searchView.viewModel.searchResult
        
        let pokemon = searchResult[indexPath.row]
        let searchText = self.searchView.viewModel.searchText
        let viewModel = SearchResultViewModel(searchText: searchText, searchResult: pokemon)
        cell.bind(to: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = self.searchView.viewModel.searchResult
        let pokemon = searchResult[indexPath.row]
        if let id = pokemon.id, let locations = self.locations {
            Network.sharedAPI.getPokemonDetail(id: "\(id)") { info in
                let searchLocationList = locations.filter { return $0.id == pokemon.id ? true : false }
                self.setPopupView(names: pokemon.names, info: info, location: searchLocationList)
            }
        }
    }
}

