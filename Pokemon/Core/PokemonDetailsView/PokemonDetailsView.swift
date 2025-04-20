//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let topCircleHeight: CGFloat = UIScreen.main.bounds.width*1.7
    private let imageURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/4.gif"
    private let monsterName: String = "Pikachu"
    private let monsterNumber: String = "1"
    
    private let elements: [PokemonElement] = [.fire, .grass]
    
    
    @State private var progress: Float = 20
    
    private let emptyElement: PokemonElement = .noElement
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    TopElementView(
                        height: topCircleHeight,
                        elementImage: elements.first?.imageName ?? emptyElement.imageName,
                        elementColor: elements.first?.color ?? emptyElement.color
                    ) .overlay(alignment: .bottom) {
                        GifImageMonster(url: imageURL)
                    } .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text(monsterName.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Text("Nº\(formatNumber(Int(monsterNumber)))")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .padding([.leading, .top])
                    .frame(width: screenWidth, alignment: .leading)
                    
                    
                    ElementFullView(elements: elements)
                        .padding(.leading)
                        .frame(width: screenWidth, alignment: .leading)
                    
                    Divider()
                        .padding()
                    
                    // MARK: - Stats
                    VStack(spacing: 13) {
                        HStack(spacing: 20) {
                            StatBlock(icon: "scalemass", label: "Weight", value: "6.9 kg")
                            StatBlock(icon: "ruler", label: "Height", value: "0.7 m")
                        }
                        
                        HStack(spacing: 20) {
                            StatBlock(icon: "leaf", label: "EXP", value: "128 EXP")
                            StatBlock(icon: "bolt.fill", label: "Ability", value: "Overgrow")
                        }
                        .padding(.bottom)
                        
                    }
                    .frame(width: screenWidth)
                    
                    Divider()
                    
                    VStack(spacing: 5) {
                        ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                        ElementProgress(title: "Attack", color: elements.first!.color, progress: $progress)
                        ElementProgress(title: "Defense", color: elements.first!.color, progress: $progress)
                        ElementProgress(title: "Special-Attack", color: elements.first!.color, progress: $progress)
                        ElementProgress(title: "Special-Defense", color: elements.first!.color, progress: $progress)
                        ElementProgress(title: "Speed", color: elements.first!.color, progress: $progress)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: screenWidth)
                    
                    Divider()
                        .padding()
                    
                    EvolutionsView()
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
            
        }
    }
    
    private  func formatNumber(_ number: Int?) -> String {
        guard let number = number else {
            return "000" // Placeholder for nil
        }
        return number <= 999 ? String(format: "%03d", number) : "\(number)"
    }
}

#Preview {
    PokemonDetailsView()
    
}
