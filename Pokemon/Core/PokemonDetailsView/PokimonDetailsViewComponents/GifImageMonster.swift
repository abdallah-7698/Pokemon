//
//  GifImageMonster.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI


struct GifImageMonster: View {
    
    let sprit: PokemonSprites
    @Binding var isShiny: Bool
    
    var body: some View {
        if !isShiny {
            if let stringURL = sprit.animated?.frontDefault, let URL = URL(string: stringURL) {
                OnlineGIFView(gifURL: URL)
                    .scaledToFill()
                    .frame(width: 180, height: 200)
                    .padding(.bottom, -20)
            } else {
                PokemonMonsterImage(url: sprit.frontDefault)
            }
        } else {
            if let stringURL = sprit.animated?.frontShiny, let URL = URL(string: stringURL) {
                OnlineGIFView(gifURL: URL)
                    .scaledToFill()
                    .frame(width: 180, height: 200)
                    .padding(.bottom, -20)
            } else {
                PokemonMonsterImage(url: sprit.frontShiny)
                    .scaledToFill()
                    .frame(width: 180, height: 200)
                    .padding(.bottom, -20)
            }
        }
    }
    
}

#Preview {
    GifImageMonster(sprit: PokemonSprites(), isShiny: .constant(false))
}
