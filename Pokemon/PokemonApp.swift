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
// change the view model so it does not load the pokemon only gives the order to download
// make the item load the show the data (animated imaeg)
// make the local data storage
// make the loading on the scroll
// make the monster evaluation with showing the levels

