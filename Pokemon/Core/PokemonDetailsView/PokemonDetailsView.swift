//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @ObservedObject var viewModel: PokemonViewModel
    
    //MARK: - Private variables
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let topCircleHeight: CGFloat = UIScreen.main.bounds.width*1.7
    let noElement: PokemonElement = .noElement
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShiny: Bool = false
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    TopElementView(
                        height: topCircleHeight,
                        elementImage: elements(from: viewModel.pokemon.types).first?.imageName ?? noElement.imageName,
                        elementColor: elements(from: viewModel.pokemon.types).first?.color ?? noElement.color
                    )
                    .overlay(alignment: .bottom) {
                        GifImageMonster(sprit: viewModel.pokemon.sprites, isShiny: $isShiny)
                    }
                    .frame(width: screenWidth)
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            isShiny.toggle()
                        } label: {
                            Image(isShiny ? "pokeball" : "shinyPokeball" )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        .padding(.bottom, -20)
                    }
                    .padding(.bottom)
                    .padding(.trailing, 40)
                    
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Text("Nº\(formatNumber(viewModel.pokemon.id))")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .padding([.leading, .top])
                    .frame(width: screenWidth, alignment: .leading)
                    
                    
                    ElementFullView(elements: elements(from: viewModel.pokemon.types))
                        .padding(.leading)
                        .frame(width: screenWidth, alignment: .leading)
                    
                    Divider()
                        .padding()
                    
                    // MARK: - Stats
                    VStack(spacing: 13) {
                        HStack(spacing: 20) {
                            StatBlock(icon: "scalemass", label: "Weight", value: "\(viewModel.pokemon.weight) kg")
                            StatBlock(icon: "ruler", label: "Height", value: "\(viewModel.pokemon.height) m")
                        }
                        
                        HStack(spacing: 20) {
                            StatBlock(icon: "leaf", label: "EXP", value: "\(viewModel.pokemon.baseExperience) EXP")
                            StatBlock(icon: "bolt.fill", label: "Ability", value: viewModel.pokemon.abilities.first?.ability.name ?? "NO ABILITY")
                        }
                        .padding(.bottom)
                        
                    }
                    .frame(width: screenWidth)
                    
                    Divider()
                    
                    VStack(spacing: 5) {
                        ForEach(viewModel.pokemon.stats) { state in
                            ElementProgress(title: state.stat.name.capitalized,
                                            color: elements(from: viewModel.pokemon.types).first?.color ?? noElement.color,
                                            progress: state.baseStat, total: 200)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: screenWidth)
                    
                    Divider()
                        .padding()
                    
                    EvolutionsView(
                        element: elements(from: viewModel.pokemon.types).first ?? noElement,
                        monsterName: viewModel.pokemon.name,
                        order: viewModel.pokemon.id)
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .frame(width: screenWidth)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .overlay(alignment: .topLeading){
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                    }
                    .padding(.leading, 20)
                    .padding(.leading, 20)
                    .shadow(radius: 5)
            }
        }
        
    }
    
    func elements(from types: [PokemonType]?) -> [PokemonElement] {
        if types != nil {
            return types!.compactMap { PokemonElement(rawValue: $0.type.name.lowercased()) }
        } else {
            return [ noElement ]
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
    PokemonDetailsView(viewModel: PokemonViewModel(url: ""))
}
