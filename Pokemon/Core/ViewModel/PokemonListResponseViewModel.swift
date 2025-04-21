//
//  PokemonListResponseViewModel.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import Foundation

class PokemonListResponseViewModel: ObservableObject {
    @Published var pokemonStringURLs = [PokemonPartial]()
    @Published var copyPokemonStringURLs = [PokemonPartial]()
    
    @Published var searchPokemon: String = "" {
        didSet {
            guard oldValue != searchPokemon else { return }
            upDateListingForLocation()
        }
    }
    
    init() { fetch() }
    
    private func fetch(offset: Int = 0, count: Int = 10277) {
        PokemonListRequest(offset: offset, limit: count).perform { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self.pokemonStringURLs.append(contentsOf: pokemonList.results)
                    self.copyPokemonStringURLs.append(contentsOf: pokemonList.results)
                }
            case .failure(let error):
                print("❌ Network error:", error.localizedDescription)
            }
        }
    }
    
    func upDateListingForLocation() {
        guard !searchPokemon.isEmpty else {
            // Reset to the original list when the search string is empty
            self.pokemonStringURLs = copyPokemonStringURLs
            return
        }

        // Always filter from the original list, not the already-filtered list
        let filterListings = copyPokemonStringURLs.filter({ $0.name.lowercased().hasPrefix(searchPokemon.lowercased()) })
        self.pokemonStringURLs = filterListings
    }
    
}
