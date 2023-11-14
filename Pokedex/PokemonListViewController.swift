//
//  ViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        
    }
    
    var pokemonManager = PokemonManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        pokemonManager.showPokemon()
    }
    
    // IBOutlets

    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
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
