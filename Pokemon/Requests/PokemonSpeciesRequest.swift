//
//  PokemonSpeciesRequest.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import Foundation
import Networking

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
