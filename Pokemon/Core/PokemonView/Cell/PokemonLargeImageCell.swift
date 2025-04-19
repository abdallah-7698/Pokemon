//
//  PokemonLargeImageCell.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//


import SwiftUI

struct PokemonLargeImageCell: View {
    
    private let pokemonStringURL: String
    @StateObject private var viewModel: PokemonViewModel
    
    init(pokemonStringURL: String) {
        self.pokemonStringURL = pokemonStringURL
        _viewModel = StateObject(wrappedValue: PokemonViewModel(url: pokemonStringURL))
    }
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 12)
                .fill(elements(from: viewModel.pokemon?.types).first?.color ?? getNoElement().color)
            
            VStack(spacing: 15) {
                
                HStack {
                    ForEach(elements(from: viewModel.pokemon?.types), id: \.self) { type in
                        ElementImageView(imageName: type.imageName, color: type.color)
                    }
                    
                    Spacer()
                    Text("#\(formatNumber(viewModel.pokemon?.id))")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(0.3))
                    
                    Image(elements(from: viewModel.pokemon?.types).first?.imageName ?? getNoElement().imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .padding()
                    
                    PokemonMonsterImage(url: viewModel.pokemon?.sprites.frontDefault)
                    
                }
                .frame(width: 150, height: 150)
                
                Text(viewModel.pokemon?.name.capitalized ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            .padding()
        }
        .frame(width: 150, height: 150)
        
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
            return "---" // Placeholder for nil
        }
        return number <= 999 ? String(format: "%03d", number) : "\(number)"
    }
    
}

#Preview {
    PokemonLargeImageCell(pokemonStringURL: "String")
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

struct PokemonMonsterImage: View {
    let url: String?
    
    var body: some View {
        VStack {
            if let url = url {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .imageScale(.small)
                        .frame(width: 100, height: 100)
                } placeholder: {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
        }
        
    }
    
}
