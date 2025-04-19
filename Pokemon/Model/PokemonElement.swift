
import SwiftUI

enum PokemonElement: String, CaseIterable {
    case fire
    case water
    case grass
    case electric
    case psychic
    case rock
    case ice
    case bug
    case fairy
    case poison
    case ghost
    case dragon
    case steel
    case flying
    case dark
    case fighting
    case ground
    case normal
    
    case noElement
    
    var imageName: String {
        return "\(rawValue)Image"
    }

    var color: Color {
        return Color("\(rawValue)Color")
    }
        
}
