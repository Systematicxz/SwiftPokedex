//
//  ViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//
import UIKit
import CoreData

class PokemonListViewController: UIViewController, PokemonManagerDelegate {
    var viewModel: PokemonListViewModel = PokemonListViewModelConcrete()
    var pokemonList: [Pokemon] = []
    var pokemonManager = PokemonManager()
    var pokemonFilter: [Pokemon] = []
    var pokemonSelected: Pokemon?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        pokemonManager.delegate = self
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        searchBarPokemon.delegate = self
        pokemonManager.showPokemon()
    }
    
    // IBOutlets
    
    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    func showListPokemon(list: [Pokemon]) {
        viewModel.storePokemonToCoreData(pokemonList: list)
        self.pokemonList = list
        
        DispatchQueue.main.async { [weak self] in
            if let searchText = self?.searchBarPokemon.text, !searchText.isEmpty {
                self?.pokemonFilter = (self?.viewModel.filterPokemonList(searchText: searchText, pokemonList: self?.pokemonList ?? []))!
            } else {
                self?.pokemonFilter = self?.pokemonList ?? []
            }
            self?.pokemonTable.reloadData()
        }
    }

}
extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTable.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = pokemonFilter[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPokemon = pokemonDetailViewController()
        let pokemonToShow = pokemonFilter[indexPath.row]
        detailPokemon.viewModel = PokemonDetailViewModelConcrete(pokemonToShow: pokemonToShow)
        navigationController?.pushViewController(detailPokemon, animated: true)
        pokemonTable.deselectRow(at: indexPath, animated: true)
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFilter = viewModel.filterPokemonList(searchText: searchText, pokemonList: pokemonList)
        pokemonTable.reloadData()
    }
}
