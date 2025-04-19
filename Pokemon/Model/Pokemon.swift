//
//  Pokemon.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import Foundation

//struct Pokemon : Decodable{
//    var results: [PokemonEntry]
//}
//
//struct PokemonEntry: Decodable {    
//    let name: String
//    let url: String
//    // you will make another request with this url to get the image you want
//    // you first will search for the animated image if not found you will get the default image
//    // you will get all models not the first 151 but you will get 20 by 20 based in how the API works
//}



/* In the future Add based on the API and design
 let description: String
 let height: Int
 let attack: Int
 let defense: Int
 let weight: Int
 let total: Int
 --> And other
 */

let MOCK_POKEMON: [PokemonEntry] = [
    .init(name: "Buldasaur 0", url: "1"),
    .init(name: "Buldasaur 1", url: "1"),
    .init(name: "Buldasaur 2", url: "1"),
    .init(name: "Buldasaur 3", url: "1"),
    .init(name: "Buldasaur 4", url: "1"),
    .init(name: "Buldasaur 5", url: "1"),
    .init(name: "Buldasaur 6", url: "1"),
    .init(name: "Buldasaur 7", url: "1")
]
