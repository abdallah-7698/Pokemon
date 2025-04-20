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
    
    private func fetch(offset: Int = 0, count: Int = 10277) {
        PokemonListRequest(offset: offset, limit: count).perform { result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self.pokemonStringURLs.append(contentsOf: pokemonList.results)
                }
            case .failure(let error):
                print("❌ Network error:", error.localizedDescription)
            }
        }
    }
}
