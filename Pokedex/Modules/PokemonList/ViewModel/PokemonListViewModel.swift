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
protocol PokemonListViewModel: AnyObject {
    func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon]
    func getPokemonListFromSource(completion: @escaping([Pokemon]) -> Void)
    func storePokemonToCoreData(pokemonList: [Pokemon])
}

class PokemonListViewModelConcrete: PokemonListViewModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
}
