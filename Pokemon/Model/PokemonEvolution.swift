//
//  PokemonEvolution.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import Foundation

//from this link https://pokeapi.co/api/v2/pokemon-species/\(id)/

struct PokemonSpecies: Decodable {
    let evolutionChain: EvolutionChainLink

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}

struct EvolutionChainLink: Decodable {
    let url: String
}

// you get this link https://pokeapi.co/api/v2/evolution-chain/2/
// from this link

struct EvolutionChainResponse: Codable {
    let chain: ChainLink
}

struct ChainLink: Codable {
    let species: Species
    let evolvesTo: [ChainLink]
    let evolutionDetails: [EvolutionDetail]

    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
        case evolutionDetails = "evolution_details"
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

struct EvolutionDetail: Codable {
    let minLevel: Int?

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
    }
}


// MARK: - The main model
struct EvolutionStage: Identifiable, Equatable {
    let id: UUID = UUID()
    
    let name: String
    let level: Int?
}


