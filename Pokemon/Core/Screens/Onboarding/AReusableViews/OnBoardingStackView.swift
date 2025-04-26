//
//  OnBoardingStackView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct OnBoardingStackView: View {
    
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            VStack(spacing: 15) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
            }
        }
    }
}

#Preview {
    OnBoardingStackView(imageName: "pikachu", title: "Pikachu", description: "Pikachu is a fictional creature from the Pokémon media franchise.")
}
