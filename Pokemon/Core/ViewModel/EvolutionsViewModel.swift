//
//  EvolutionsViewModel.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import Foundation


class EvolutionsViewModel: ObservableObject {
    @Published var EvolutionStages: [EvolutionStage] = []
    
    func fetchEvolutionChainURLS(for id: Int) {
        PokemonSpeciesRequest(id: id).perform { result in
            switch result {
            case .success(let peciesURL):
                let apiURL = peciesURL.evolutionChain.url
                let url = self.sanitizedURL(from: apiURL)
                guard let url = URL(string: url) else {return}
                EvolutionChainRequest(url: url).perform { result in
                    switch result {
                    case .success(let chain):
                        DispatchQueue.main.async {
                            self.EvolutionStages = self.extractEvolutionNames(from: chain.chain)
                        }
                    case .failure(let error):
                        print("❌ Network request:", error.localizedDescription)
                    }
                }
            case .failure(let error):
                print("❌ Network request:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get the list of item my converting the chain of items to array (Recursion Algorithm)
    func extractEvolutionNames(from chain: ChainLink, level: Int? = nil) -> [EvolutionStage] {
        var result: [EvolutionStage] = [.init(name: chain.species.name, level: level)]
        for evolution in chain.evolvesTo {
            let evoLevel = evolution.evolutionDetails.first?.minLevel
            result += extractEvolutionNames(from: evolution, level: evoLevel)
        }
        return result
    }
    
    private func sanitizedURL(from urlString: String) -> String {
        if urlString.hasSuffix("/") {
            return String(urlString.dropLast())
        } else {
            return urlString
        }
    }
}
