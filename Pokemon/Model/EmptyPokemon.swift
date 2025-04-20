//
//  EmptyPokemon.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import Foundation

/// Empty Pokemon implementation with default values
extension Pokemon {
    /// Creates an empty Pokemon object with default values
    static var empty: Pokemon {
        Pokemon(
            id: 0,
            name: "",
            baseExperience: 0,
            height: 0,
            weight: 0,
            sprites: PokemonSprites(),
            abilities: [],
            stats: [],
            types: []
        )
    }
}

extension PokemonSprites {
    init(frontDefault: String? = nil, frontShiny: String? = nil, animated: AnimatedSprites? = nil) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.animated = animated
    }
}
