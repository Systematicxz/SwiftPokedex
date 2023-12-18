//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ezequiel Barreto on 12/12/23.
//

import Foundation
import UIKit

protocol PokemonDetailViewModel: AnyObject {
    func getNumberOfRows() -> Int
    func getImageURL() -> String
    func getValueReusable(forSection section: PokemonDetailSection) -> Any
    func getInfoData() -> (attack: Int, defense: Int)?
    func getView() -> UIViewController?
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
    func getView() -> UIViewController? {
        guard pokemonToShow != nil else { return nil }
        let detailViewController = pokemonDetailViewController()
        detailViewController.viewModel = self
        return detailViewController
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

