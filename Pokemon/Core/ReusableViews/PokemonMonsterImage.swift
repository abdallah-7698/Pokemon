//
//  PokemonMonsterImage.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//
import SwiftUI
import Kingfisher

struct PokemonMonsterImage: View {
    let url: String?
    
    var body: some View {
        VStack {
            if let url = url, let imageURL = URL(string: url) {
                KFImage(imageURL)
                    .resizable()
                    .placeholder {
                        ProgressView()
                            .scaleEffect(2)
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .scaledToFit()
            } else {
                EmptyView()
            }
        }
    }
}
