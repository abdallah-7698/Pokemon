//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct PokemonDetailsView: View {
    
//    get the monster from the cahe or connect to the same view mode of the cell item
    var pokemonStringURL: String {
        didSet{
            print("name: \(pokemonStringURL)")
        }
    }
    
    //MARK: - Init variables
    let imageURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/4.gif"
   
    let monsterName: String = "Pikachu"
    let monsterNumber: Int = 1
    let elements: [PokemonElement] = [.ground, .grass]

    let monsterWeight: Float = 9.6
    let monsterHeight: Float = 0.4
    let monsterExp: Int = 112
    let monsterAbility: String = "Static"
        
    @State var hp: Float = 20
    @State var attack: Float = 44
    @State var defense: Float = 15
    @State var specialAttack: Float = 88
    @State var specialDefense: Float = 70
    @State var speed: Float = 44
    
    //MARK: - Private variables
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let topCircleHeight: CGFloat = UIScreen.main.bounds.width*1.7
    let emptyElement: PokemonElement = .noElement
   
    @Environment(\.dismiss) var dismiss

    
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
                        
                        Text("Nº\(formatNumber(monsterNumber))")
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
                            StatBlock(icon: "scalemass", label: "Weight", value: "\(monsterWeight) kg")
                            StatBlock(icon: "ruler", label: "Height", value: "\(monsterHeight) m")
                        }
                        
                        HStack(spacing: 20) {
                            StatBlock(icon: "leaf", label: "EXP", value: "\(monsterExp) EXP")
                            StatBlock(icon: "bolt.fill", label: "Ability", value: monsterAbility)
                        }
                        .padding(.bottom)
                        
                    }
                    .frame(width: screenWidth)
                    
                    Divider()
                    
                    VStack(spacing: 5) {
                        ElementProgress(title: "HP", color: elements.first!.color, progress: .constant(hp))
                        ElementProgress(title: "Attack", color: elements.first!.color, progress: .constant(attack))
                        ElementProgress(title: "Defense", color: elements.first!.color, progress: .constant(defense))
                        ElementProgress(title: "Special-Attack", color: elements.first!.color, progress: .constant(specialAttack))
                        ElementProgress(title: "Special-Defense", color: elements.first!.color, progress: .constant(specialDefense))
                        ElementProgress(title: "Speed", color: elements.first!.color, progress: .constant(speed))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: screenWidth)
                    
                    Divider()
                        .padding()
                    
                    EvolutionsView(element: elements.first ?? emptyElement,
                                   monsterName: monsterName,
                                   order: monsterNumber)
                    
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
    
    private  func formatNumber(_ number: Int?) -> String {
        guard let number = number else {
            return "000" // Placeholder for nil
        }
        return number <= 999 ? String(format: "%03d", number) : "\(number)"
    }
}

#Preview {
    PokemonDetailsView(pokemonStringURL: "")
    
}
