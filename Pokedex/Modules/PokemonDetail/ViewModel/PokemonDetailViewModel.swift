//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ezequiel Barreto on 12/12/23.
//

import Foundation

protocol PokemonDetailViewModel: AnyObject {
    func getNumberOfRows() -> Int
    func getImageURL() -> String
    func getValueReusable(forSection section: PokemonDetailSection) -> Any
    func getInfoData() -> (attack: Int, defense: Int)?
}

class PokemonDetailViewModelConcrete: PokemonDetailViewModel {
    var pokemonToShow: Pokemon?

    init(pokemonToShow: Pokemon? = nil) {
        self.pokemonToShow = pokemonToShow
    }

    func getNumberOfRows() -> Int {
        PokemonDetailSection.allCases.count
    }

    func getImageURL() -> String {
        pokemonToShow?.imageUrl ?? ""
    }
    
    func getInfoData() -> (attack: Int, defense: Int)? {
        (pokemonToShow?.attack ?? 0, pokemonToShow?.defense ?? 0)
    }
    
    
    func getValueReusable(forSection section: PokemonDetailSection) -> Any {
        switch section {
        case .title:
            pokemonToShow?.name ?? ""
        case .image:
            getImageURL()
        case .info:
            getInfoData() ?? ("", "")
        case .type:
            "Type: \(pokemonToShow?.type ?? "")"
        case .description:
            pokemonToShow?.description ?? ""
        }
    }
}

