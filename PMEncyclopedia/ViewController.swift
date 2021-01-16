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
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

