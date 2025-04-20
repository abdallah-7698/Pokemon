//
//  PokemonView.swift
//  Pokemon
//
//  Created by name on 18/04/2025.
//

import SwiftUI

struct PokemonView: View {
    @State private var searchText = ""
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
                    TextField("Search", text: $searchText)
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
                        ForEach(viewModel.pokemonStringURLs.indices, id: \.self) { index in
                            NavigationLink(
                                destination: PokemonDetailsView(loadingURL: viewModel.pokemonStringURLs[index].url)
                            ) {
                                PokemonLargeImageCell(loadingURL: viewModel.pokemonStringURLs[index].url)
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
