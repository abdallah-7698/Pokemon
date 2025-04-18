//
//  PokemonCell.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//

import SwiftUI

struct PokemonCell: View {
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                Text("Bulbasour")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 7)
                    .padding(.leading)
                
                HStack {
                    Text("Poison")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.25))
                        }
                        .frame(width: 110, height: 24)
                    
                    Image("bulbasaur 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                        .padding([.bottom, .trailing], 5)
                }
                
            }
        }
        .background(Color.green)
        .cornerRadius(12)
        .shadow(color: .green,radius: 4)
        
    }
}

#Preview {
    PokemonCell()
}
