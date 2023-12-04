//
//  ViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        self.pokemonList = list
        DispatchQueue.main.async { [weak self] in
            self?.pokemonFilter = self!.pokemonList
            self?.pokemonTable.reloadData()
        }
    }
    
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
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
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
        detailPokemon.pokemonToShow = pokemonFilter[indexPath.row]
        navigationController?.pushViewController(detailPokemon, animated: true)
        
        pokemonTable.deselectRow(at: indexPath, animated: true)
    }    
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        pokemonFilter = []
        if searchText == "" {
            pokemonFilter = pokemonList
        } else {
                for pokemon in pokemonList {
                    if pokemon.name.lowercased().contains(searchText.lowercased()) {
                        pokemonFilter.append(pokemon)
                    }
                }
            }
        self.pokemonTable.reloadData()
        }
    }


