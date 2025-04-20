//
//  ElementFullView.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI

struct ElementFullView: View {
    
    let elements: [PokemonElement]
    
    var body: some View {
        HStack {
            ForEach(elements, id: \.self) { element in
                HStack {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 35, height: 35)
                        
                        Image(element.imageName)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(element.color)
                            .frame(width: 20)
                    }
                    Text(element.rawValue)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(element.color)
                .cornerRadius(20)
            }
        }
    }
    
}


#Preview {
    ElementFullView(elements: [.ice, .flying, .water])
}
