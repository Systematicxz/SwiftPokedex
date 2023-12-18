//
//  ViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//
import UIKit
import CoreData

class PokemonListViewController: UIViewController, PokemonManagerDelegate, PokemonListViewModelDelegate {
    func didUpdatePokemonList() {
        DispatchQueue.main.async { [weak self] in
            self?.pokemonTable.reloadData()
        }
    }
    
    var viewModel: PokemonListViewModel = PokemonListViewModelConcrete()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPokemonList()
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        searchBarPokemon.delegate = self
    }
    
    // IBOutlets
    
    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    func showListPokemon(list: [Pokemon]) {
        let searchText = searchBarPokemon.text
        viewModel.showListPokemon(list: list, searchText: searchText)
    }
}
extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTable.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        viewModel.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailView = viewModel.getPokemonDetail(at: indexPath).getView() {
            navigationController?.pushViewController(detailView, animated: true)
        }
        pokemonTable.deselectRow(at: indexPath, animated: true)
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.showListPokemon(list: viewModel.pokemonList, searchText: searchText)
    }
}
