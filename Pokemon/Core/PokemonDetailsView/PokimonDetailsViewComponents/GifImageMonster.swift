//
//  GifImageMonster.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI


struct GifImageMonster: View {
    
    let url: String?
    
    var body: some View {
        if let stringURL = url, let URL = URL(string: stringURL) {
            OnlineGIFView(gifURL: URL)
                .scaledToFill()
                .frame(width: 180, height: 200)
                .padding(.bottom, -20)
        } else {
            PokemonMonsterImage(url: url)
        }
    }
}

#Preview {
    GifImageMonster(url: nil)
}
