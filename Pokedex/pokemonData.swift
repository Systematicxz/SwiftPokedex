//
//  pokemonData.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let name: String
    let type: String
}
