//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by [Your Name] on [Date].
//  Description: ViewModel to fetch and manage Pokémon data from the PokéAPI.
//

import Foundation

@MainActor
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

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon? = nil
    
    init(url: String) { fetchPokemon(from: url) }
    
    func fetchPokemon(from url: String) {
    
        let newURL = sanitizedURL(from: url)
        guard let url = URL(string: newURL) else { return }
    
        PokemonRequest(baseUrl: url).perform { result in
                switch result {
                    case .success(let pokemon):
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                    }
                case .failure(let error):
                    print("❌ Network error:", error.localizedDescription)
                }
        }
    }
    
    private func sanitizedURL(from urlString: String) -> String {
        if urlString.hasSuffix("/") {
            return String(urlString.dropLast())
        } else {
            return urlString
        }
    }
    
}
