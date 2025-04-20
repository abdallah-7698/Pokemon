//
//  PokemonListResponseViewModel.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import Foundation

class PokemonListResponseViewModel: ObservableObject {
    @Published var pokemonStringURLs = [PokemonPartial]()
    
    init() { fetch() }
    
    func fetch() {
        PokemonListRequest().perform { result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self.pokemonStringURLs = pokemonList.results
                }
            case .failure(let error):
                print("❌ Network error:", error.localizedDescription)
            }
        }
    }
}
