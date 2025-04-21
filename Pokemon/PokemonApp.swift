//
//  PokemonApp.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//

import SwiftUI
import Kingfisher

@main
struct PokemonApp: App {
   
    init() {
            // Set the memory cache size limit (e.g., 50 MB)
            ImageCache.default.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024
        
            // Set the disk cache size limit (e.g., 100 MB)
            ImageCache.default.diskStorage.config.sizeLimit = 100 * 1024 * 1024
        }
    
    var body: some Scene {
        WindowGroup {
            PokemonView()
        }
    }
}

//TODO: - Next
// show the evaluations
// make the login and the other screens
// add filter with lement with this https://pokeapi.co/api/v2/type/10/
