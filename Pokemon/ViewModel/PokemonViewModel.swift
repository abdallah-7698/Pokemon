//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by [Your Name] on [Date].
//  Description: ViewModel to fetch and manage Pokémon data from the PokéAPI.
//

import Foundation

// Strp 1
struct PokemonListResponse: Codable {
    let results: [PokemonPartial]
}

struct PokemonPartial: Codable {
    let url: String
}

// step 2

struct Pokemon: Codable {
    let id: Int
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

// 1

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

// 2

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

// 3

struct PokemonStat: Codable {
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

// End

// will remove this code
struct PokemonEntry {
    let name: String
    let url: String
}

//      ----------------------------- from the url you will get---------------------------------------
// -> I think the memory will be full in with this data to each cark ---> find a solution to this -- or focus on this point

class PokemonListResponseViewModel: ObservableObject {
    @Published var pokemonStringURLs = [PokemonPartial]()
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=50"
    
    init() {
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Network error:", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Server error")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
                        
            do {
                let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonStringURLs = decodedResponse.results
                    print("❌ Loaded \(self.pokemonStringURLs.count) Pokémon")
                }
            } catch {
                print("❌ Decoding error:", error)
            }
            
        }.resume()
    }

}

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon? = nil
        
    init(url: String) {
        fetchPokemon(from: url)
    }
    
    func fetchPokemon(from url: String) {
        
        let newURL = sanitizedURL(from: url)
        
        guard let url = URL(string: newURL) else { return }
        
        print("❌", url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Network error:", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Server error")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
                        
            do {
                let decodedResponse = try JSONDecoder().decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    self.pokemon = decodedResponse
                }
            } catch {
                print("❌ Decoding error:", error)
            }
            
        }.resume()
    }

    private func sanitizedURL(from urlString: String) -> String {
        if urlString.hasSuffix("/") {
            return String(urlString.dropLast())
        } else {
            return urlString
        }
    }
    
}
