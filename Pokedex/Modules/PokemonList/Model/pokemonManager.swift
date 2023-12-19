//
//  pokemonManager.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 13/11/23.
//

import Foundation


protocol PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon])
}

class PokemonManager {
    static let shared = PokemonManager()
    
    var delegate: PokemonManagerDelegate?
    var viewModel: PokemonListViewModel?
    
    private init() {}
    
    func showPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error to call the API", error?.localizedDescription as Any)
                }
                if let secureData = data?.parseData(removeString: "null,") {
                    if let listPokemon = self.parseJSON(dataPokemon: secureData) {
                        self.delegate?.showListPokemon(list: listPokemon)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(dataPokemon: Data) -> [Pokemon]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Pokemon].self, from: dataPokemon)
            return decodedData
        }catch {
            print("Error to decode data", error.localizedDescription)
            return nil
        }
    }
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsSting = String(data: self, encoding: .utf8)
        let parseDataString = dataAsSting?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
