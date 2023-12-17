//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/12/23.
//
import UIKit
import Foundation
import CoreData


public let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
protocol PokemonListViewModelDelegate: AnyObject {
    func didUpdatePokemonList()
}
protocol PokemonListViewModel: AnyObject {
    var pokemonList: [Pokemon] { get }
    var pokemonFilter: [Pokemon] { get }
    var pokemonSelected: Pokemon? { get }
    var filteredPokemonList: [Pokemon] { get }
    
    func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon]
    func getPokemonListFromSource(completion: @escaping([Pokemon]) -> Void)
    func storePokemonToCoreData(pokemonList: [Pokemon])
    func didUpdatePokemonList()
    var delegate: PokemonListViewModelDelegate? { get set }
    func updateFilteredPokemonList(with filter: [Pokemon])
    func fetchPokemonList()
    func showListPokemon(list: [Pokemon], searchText: String?)
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath)
    func getPokemonDetail(at indexPath: IndexPath) -> PokemonDetailViewModelConcrete
}



class PokemonListViewModelConcrete: PokemonListViewModel {
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = pokemonFilter[indexPath.row].name
    }
    func getPokemonDetail(at indexPath: IndexPath) -> PokemonDetailViewModelConcrete {
        let pokemonToShow = pokemonFilter[indexPath.row]
        let detailViewModel = PokemonDetailViewModelConcrete(pokemonToShow: pokemonToShow)
        return detailViewModel
    }
    func getPokemonListFromSource(completion: @escaping ([Pokemon]) -> Void) {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        
        do {
            let pokemonEntities = try context.fetch(request)
            var pokemonListFromCoreData: [Pokemon] = []
            
            for pokemonEntity in pokemonEntities {
                let pokemon = Pokemon(
                    id: Int(pokemonEntity.id),
                    attack: Int(pokemonEntity.attack),
                    name: String(pokemonEntity.name ?? ""),
                    type: String(pokemonEntity.type ?? ""),
                    defense: Int(pokemonEntity.defense),
                    description: String(pokemonEntity.description),
                    imageUrl: pokemonEntity.imageUrl ?? ""
                )
                pokemonListFromCoreData.append(pokemon)
            }
            completion(pokemonListFromCoreData)
            
        } catch {
            print("Error fetching data from Core Data: \(error)")
            completion([])
        }
    }
    func didUpdatePokemonList() {
        delegate?.didUpdatePokemonList()
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filteredPokemonList: [Pokemon] = []
    var pokemonList: [Pokemon] = []
    var pokemonFilter: [Pokemon] = []
    var pokemonSelected: Pokemon?
    weak var delegate: PokemonListViewModelDelegate?
    private var pokemonManager = PokemonManager()
    
    func showPokemonDetail(at index: Int) -> PokemonDetailViewModelConcrete {
        let pokemonToShow = pokemonFilter[index]
        let detailViewModel = PokemonDetailViewModelConcrete(pokemonToShow: pokemonToShow)
        return detailViewModel
    }
    func updateFilteredPokemonList(with filter: [Pokemon]) {
        pokemonFilter = filter
    }
    func fetchPokemonList() {
        pokemonManager.delegate = self
        pokemonManager.showPokemon()
    }
    func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon] {
        if searchText.isEmpty {
            return pokemonList // Devuelve la lista original si searchText está vacío
        } else {
            let filteredList = pokemonList.filter { pokemon in
                return pokemon.name.lowercased().contains(searchText.lowercased())
            }
            delegate?.didUpdatePokemonList()
            return filteredList // Devuelve la lista filtrada
        }
    }
    
    func storePokemonToCoreData(pokemonList: [Pokemon]) {
        DispatchQueue.global().async { [weak self] in
            for pokemon in pokemonList {
                let pokemonEntity = PokemonEntity(context: self!.context)
                pokemonEntity.name = pokemon.name
                pokemonEntity.id = Int16(pokemon.id)
                pokemonEntity.attack = Int16(pokemon.attack)
                pokemonEntity.defense = Int16(pokemon.defense)
                pokemonEntity.type = pokemon.type
                pokemonEntity.imageUrl = pokemon.imageUrl
                
                do {
                    try self?.context.save()
                } catch let error {
                    print("Error saving data to Core Data: \(error)")
                }
            }
        }
    }
    func showListPokemon(list: [Pokemon], searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            let filteredPokemon = filterPokemonList(searchText: searchText, pokemonList: list)
            updateFilteredPokemonList(with: filteredPokemon)
            filteredPokemonList = filteredPokemon
        } else {
            updateFilteredPokemonList(with: pokemonList)
            filteredPokemonList = pokemonList
        }
        delegate?.didUpdatePokemonList()
    }
}

func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon] {
    if searchText.isEmpty {
        return pokemonList
    } else {
        let filteredList = pokemonList.filter { pokemon in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        }
        return filteredList
    }
}
extension PokemonListViewModelConcrete: PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        pokemonList = list
        pokemonFilter = list
        delegate?.didUpdatePokemonList()
        updateFilteredPokemonList(with: list)
        filteredPokemonList = list
        delegate?.didUpdatePokemonList()
    }
}
