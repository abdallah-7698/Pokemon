//
//  EvolutionsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct EvolutionsView: View {
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    let element: PokemonElement = .fire
    let images: [String] = [
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png"
    ]
    let monsterName: String = "Charmander"
    let order: Int = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Evolutions")
                .textCase(.uppercase)
                .font(.title3)
                .fontWeight(.medium)
                .padding(5)
            
            VStack(alignment: .leading, spacing: 5) {
                VStack {
                    ForEach(images, id: \.self) { image in
                        EvolutionsMonster(name: monsterName, order: order, url: image, element: element).frame(height: 80)
                        //                        arrowUpdate()
                    }
                    
                }
                .padding(.vertical)
                
            }
            .padding(.horizontal, 20)
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.gray)
                    .opacity(0.2)
            }
            .frame(width: screenWidth - 30)
        }
    }
    
    struct EvolutionsMonster: View {
        
        let name: String
        let order: Int
        let url: String
        
        let element: PokemonElement
        
        var body: some View {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(element.color)
                    Image(element.imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.clear)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .mask(
                                Image(element.imageName)
                                    .resizable()
                                    .scaledToFit()
                            )
                        )
                    
                }
                .overlay(content: {
                    PokemonMonsterImage(url: url)
                        .scaledToFill()
                })
                .frame(width: 120)
                
                VStack(alignment: .leading) {
                    Text(name.capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Nº\(formatNumber(Int(order)))")
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.gray)
                    .opacity(0.2)
            }
            
        }
        
        private  func formatNumber(_ number: Int?) -> String {
            guard let number = number else {
                return "000" // Placeholder for nil
            }
            return number <= 999 ? String(format: "%03d", number) : "\(number)"
        }
    }
    
    struct arrowUpdate: View {
        var body: some View {
            HStack {
                Image(systemName: "arrowshape.down.fill")
                    .resizable()
                    .imageScale(.large)
                    .frame(width: 20, height: 30)
                Text("UP DATE")
            }
            .foregroundColor(.dark)
        }
    }
    
}

#Preview {
    EvolutionsView()
}
