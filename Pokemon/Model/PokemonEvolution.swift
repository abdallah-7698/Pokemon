//
//  PokemonEvolution.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import Foundation
import Networking

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

struct EvolutionStage: Identifiable, Equatable {
    let id: UUID = UUID()
    
    let name: String
    let level: Int?
}

// Model end

struct PokemonSpeciesRequest: RequestType {
    public var baseUrl: URL
    public var path: String = String()
    public var method: String = "GET"
    var validStatusCode: [Int] = [200]
        
    public let responseDecoder: (Data) throws -> PokemonSpecies = { data in
        try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    init(id: Int) {
        self.baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)") ?? URL(string: "")!
    }
}

struct EvolutionChainRequest: RequestType {
    public var baseUrl: URL
    public var path: String = String()
    public var method: String = "GET"
    var validStatusCode: [Int] = [200]
        
    public let responseDecoder: (Data) throws -> EvolutionChainResponse = { data in
        try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    init(url: URL) {
        self.baseUrl = url
    }
}


class EvolutionsViewModel: ObservableObject {
    @Published var EvolutionStages: [EvolutionStage] = []
    
    func fetchEvolutionChainURLS(for id: Int) {
        PokemonSpeciesRequest(id: id).perform { result in
            switch result {
            case .success(let peciesURL):
                let apiURL = peciesURL.evolutionChain.url
                let url = self.sanitizedURL(from: apiURL)
                guard let url = URL(string: url) else {return}
                EvolutionChainRequest(url: url).perform { result in
                    switch result {
                    case .success(let chain):
                        DispatchQueue.main.async {
                            self.EvolutionStages = self.extractEvolutionNames(from: chain.chain)
                        }
                    case .failure(let error):
                        print("❌ Network request:", error.localizedDescription)
                    }
                }
            case .failure(let error):
                print("❌ Network request:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get the list of item my converting the chain of items to array (Recursion Algorithm)
    func extractEvolutionNames(from chain: ChainLink, level: Int? = nil) -> [EvolutionStage] {
        var result: [EvolutionStage] = [.init(name: chain.species.name, level: level)]
        for evolution in chain.evolvesTo {
            let evoLevel = evolution.evolutionDetails.first?.minLevel
            result += extractEvolutionNames(from: evolution, level: evoLevel)
        }
        return result
    }
    
    private func sanitizedURL(from urlString: String) -> String {
        if urlString.hasSuffix("/") {
            return String(urlString.dropLast())
        } else {
            return urlString
        }
    }
}
