//
//  EvolutionsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct EvolutionsView: View {
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    @StateObject private var viewModel: EvolutionsViewModel = .init()
        
    let element: PokemonElement
    let images: [String] = [
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png"
    ]
    let monsterName: String
    
    @Binding var order: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Evolutions")
                .textCase(.uppercase)
                .font(.title3)
                .fontWeight(.medium)
                .padding(5)
            
            VStack(alignment: .leading, spacing: 5) {
                VStack {
                    ForEach(viewModel.EvolutionStages) { stage in
                        if let level = stage.level {
                            arrowUpdate(level: level)
                        }
                        EvolutionsMonster(oneStageEvolutionMonsterName: stage.name)
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
        .onChange(of: order, { _, newValue in
            viewModel.fetchEvolutionChainURLS(for: newValue)
        })
    }
}

// MARK: - View Components

struct EvolutionsMonster: View {
        
    let oneStageEvolutionMonsterName: String
        
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(elements(from: viewModel.pokemon.types).first?.color ?? getNoElement().color)
                Image(elements(from: viewModel.pokemon.types).first?.imageName ?? getNoElement().imageName)
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
                            Image(elements(from: viewModel.pokemon.types).first?.imageName ?? getNoElement().imageName)
                                .resizable()
                                .scaledToFit()
                        )
                    )
                
            }
            .frame(width: 120, height: 80)
            .overlay(content: {
                PokemonMonsterImage(url: viewModel.pokemon.sprites.frontDefault)
                    .scaledToFill()
            })
            
            
            VStack(alignment: .leading) {
                Text(viewModel.pokemon.name.capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Nº\(formatNumber(Int(viewModel.pokemon.id)))")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .onAppear { viewModel.fetchPokemon(from: "https://pokeapi.co/api/v2/pokemon/\(oneStageEvolutionMonsterName)") }
        .overlay {
            RoundedRectangle(cornerRadius: 40)
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
                .opacity(0.2)
        }
        
    }
    
    func elements(from types: [PokemonType]?) -> [PokemonElement] {
        if types != nil {
            return types!.compactMap { PokemonElement(rawValue: $0.type.name.lowercased()) }
        } else {
            return [ getNoElement() ]
        }
    }
    
    func getNoElement() -> PokemonElement {
        return PokemonElement(rawValue: "noElement")!
    }
    
    private  func formatNumber(_ number: Int?) -> String {
        guard let number = number else {
            return "000" // Placeholder for nil
        }
        return number <= 999 ? String(format: "%03d", number) : "\(number)"
    }
}

struct arrowUpdate: View {
    let level: Int
    var body: some View {
        HStack {
            Image(systemName: "arrowshape.down.fill")
                .resizable()
                .imageScale(.large)
                .frame(width: 20, height: 30)
            Text("Level \(level)")
        }
        .foregroundColor(.dark)
    }
}


#Preview {
    EvolutionsView(element: .noElement, monsterName: "", order: .constant(0))
}
