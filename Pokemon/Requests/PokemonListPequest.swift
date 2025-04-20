//
//  PokemonListPequest.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation
import Networking

struct PokemonListRequest: RequestType {
    public var baseUrl: URL { Constants.PokemonDB }
    public var path: String = String()
    public var method: String = "GET"
    var validStatusCode: [Int] = [200]
    
    var queryParameters: [String : String]
    
    public let responseDecoder: (Data) throws -> PokemonListResponse = { data in
        try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    init(offset: Int, limit: Int) {
        queryParameters = ["offset": "\(offset)", "limit": "\(limit)"]
    }
    
}
