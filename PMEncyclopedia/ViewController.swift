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
    var popupView = PokemonInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchView.delegate = self
        //Service
        Network.sharedAPI.getPokemonName { (pokemons) in
            let viewModel = SearchViewModel(pokemons: pokemons)
            self.searchView.bind(to: viewModel)
        }
        //
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SearchResultCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //
        self.popupView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: 300)
        self.popupView.center = view.center
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
        //        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
        //            self.navigationController?.present(detailVC, animated: true, completion: {
        //
        //            })
        //        }
        let searchResult = self.searchView.viewModel.searchResult
        let pokemon = searchResult[indexPath.row]
        if let id = pokemon.id {
            Network.sharedAPI.getPokemonDetail(id: "\(id)") { info in
                Network.sharedAPI.getPokeLocation { location in
                    let location = location?.locations ?? []
                    let searchLocationList = location.filter { return $0.id == pokemon.id ? true : false }
                    self.setPopupView(names: pokemon.names, info: info, location: searchLocationList)
                }
            }
        }
    }
}

