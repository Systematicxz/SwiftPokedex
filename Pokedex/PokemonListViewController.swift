//
//  ViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//

import UIKit

class PokemonListViewController: UIViewController {

    var pokemonManager = PokemonManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - IBOutlets

    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!

    private func setupView() {
        pokemonManager.delegate = self
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        pokemonManager.showPokemon()
    }
}

// MARK: - PokemonManagerDelegate

extension PokemonListViewController: PokemonManagerDelegate {

    func showListPokemon(list: [Pokemon]) {
        
    }
}

// MARK: - UITableViewDelegate

extension PokemonListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTable.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = "Example"
        return cell
    }
}

// MARK: - UITableViewDataSource

extension PokemonListViewController: UITableViewDataSource {
    
}
