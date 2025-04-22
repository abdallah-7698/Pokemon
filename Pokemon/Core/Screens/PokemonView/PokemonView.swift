//
//  PokemonView.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//

import SwiftUI

struct PokemonView: View {

    private let gridItems = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    @StateObject private var viewModel = PokemonListResponseViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                    TextField("Search", text: $viewModel.searchPokemon)
                }
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray)
                )
                .padding(.horizontal)
                ScrollView {
                    Spacer()
                    
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        ForEach(viewModel.pokemonStringURLs, id: \.name) { urls in
                            NavigationLink(
                                destination: PokemonDetailsView(loadingURL: urls.url)
                            ) {
                                PokemonLargeImageCell(loadingURL: urls.url)
                                    .frame(height: 270)
                            }
                            
                        }
                    }
                
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 30)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("game")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        Text("Pokédex")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonView()
}
