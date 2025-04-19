//
//  PokemonMonsterImage.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct PokemonMonsterImage: View {
    let url: String?
    
    var body: some View {
        VStack {
            if let url = url {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
        }
        
    }
    
}
