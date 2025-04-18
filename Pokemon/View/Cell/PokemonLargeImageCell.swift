//
//  PokemonLargeImageCell.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//

import SwiftUI

struct PokemonLargeImageCell: View {
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.green)
            
            VStack(spacing: 15) {
                
                HStack {
                    ElementImageView(imageName: "Vector", color: .green)

                    Spacer()
                    Text("#001")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(0.3))
                    
                    Image("Vector")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .padding()
                    
                    Image("bulbasaur 1")
                        .resizable()
                        .scaledToFit()
                        .imageScale(.small)
                        .frame(width: 100, height: 100)
                    
                }
                .frame(width: 150, height: 150)
                
                
                
                Text("Bulbasour")
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            .padding()
        }
        .frame(width: 150, height: 150)
        
        
    }
}

#Preview {
    PokemonLargeImageCell()
}

struct ElementImageView: View {
    let imageName: String
    let color: Color
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 20)
            }
        }
    }
}
