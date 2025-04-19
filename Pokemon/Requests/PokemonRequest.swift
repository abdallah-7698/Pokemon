//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation
import Networking

struct PokemonRequest: RequestType {
    public var baseUrl: URL
    public var path: String = String()
    public var method: String = "GET"
    var validStatusCode: [Int] = [200]
        
    public let responseDecoder: (Data) throws -> Pokemon = { data in
        try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}
