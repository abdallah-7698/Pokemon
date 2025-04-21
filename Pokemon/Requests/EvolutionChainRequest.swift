//
//  EvolutionChainRequest.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import Foundation
import Networking

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
