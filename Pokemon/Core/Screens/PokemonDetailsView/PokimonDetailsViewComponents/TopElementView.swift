//
//  TopElementView.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI

struct TopElementView: View {
    
    let height: CGFloat
    let elementImage: String
    let elementColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [elementColor.opacity(1), elementColor.opacity(0.3)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
                .frame(width: height, height: height)
                .offset(y: -height / 4)
            
            Image(elementImage)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 180)
                .foregroundColor(.clear)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0.2)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(
                        Image(elementImage)
                            .resizable()
                            .scaledToFit()
                    )
                )
                .offset(y: 40)
        }
        .frame(height: height / 2)
        .padding(.bottom, 20)
    }
}

#Preview {
    TopElementView(height: UIScreen.main.bounds.width*1.7,
                   elementImage: PokemonElement.normal.imageName,
                   elementColor: PokemonElement.normal.color)
}
