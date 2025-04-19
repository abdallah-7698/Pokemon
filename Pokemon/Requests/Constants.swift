//
//  Constants.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation

enum Constants {

    static let PokemonDB: URL = {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            preconditionFailure("Invalid URL")
        }

        return url
    }()

}
