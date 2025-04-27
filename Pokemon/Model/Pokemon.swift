//
//  Pokemon.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation

/// Pokemon details that we get from the PokemonListResponse url
/// Contains all the info about Pokemon
struct Pokemon: Codable {
    
    var id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let abilities: [PokemonAbility]
    let stats: [PokemonStat]
    let types: [PokemonType]
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, abilities, stats, types, sprites
        case baseExperience = "base_experience"
    }
}

/// Contains the pokemons images
struct PokemonSprites: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let animated: AnimatedSprites?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case versions
    }

    enum VersionsKeys: String, CodingKey {
        case generationV = "generation-v"
    }

    enum GenerationVKeys: String, CodingKey {
        case blackWhite = "black-white"
    }

    enum BlackWhiteKeys: String, CodingKey {
        case animated
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
        frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)

        if let versionsContainer = try? container.nestedContainer(keyedBy: VersionsKeys.self, forKey: .versions),
           let generationVContainer = try? versionsContainer.nestedContainer(keyedBy: GenerationVKeys.self, forKey: .generationV),
           let blackWhiteContainer = try? generationVContainer.nestedContainer(keyedBy: BlackWhiteKeys.self, forKey: .blackWhite) {
            animated = try blackWhiteContainer.decodeIfPresent(AnimatedSprites.self, forKey: .animated)
        } else {
            animated = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(frontDefault, forKey: .frontDefault)
        try container.encodeIfPresent(frontShiny, forKey: .frontShiny)

        if let animated = animated {
            var versionsContainer = container.nestedContainer(keyedBy: VersionsKeys.self, forKey: .versions)
            var generationVContainer = versionsContainer.nestedContainer(keyedBy: GenerationVKeys.self, forKey: .generationV)
            var blackWhiteContainer = generationVContainer.nestedContainer(keyedBy: BlackWhiteKeys.self, forKey: .blackWhite)
            try blackWhiteContainer.encode(animated, forKey: .animated)
        }
    }
}

struct AnimatedSprites: Codable {
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

/// Contains the Pokemon Abilities
struct PokemonAbility: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case slot
        case ability
        case isHidden = "is_hidden"
    }
}

/// Contains the pokemon poerr
struct PokemonStat: Codable, Identifiable {
    var id: UUID = .init()
    
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// 4

struct PokemonType: Codable {
    let slot: Int
    let type: NamedAPIResource
}

// reused

struct NamedAPIResource: Codable {
    let name: String
}
