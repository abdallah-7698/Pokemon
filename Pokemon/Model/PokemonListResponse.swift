//
//  PokemonListResponse.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation

/// Get the pokemon list of URLs that contains the pokemon Info
struct PokemonListResponse: Codable {
    let results: [PokemonPartial]
}

struct PokemonPartial: Codable, Equatable {
    let url: String
    let name: String
}
