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
}

