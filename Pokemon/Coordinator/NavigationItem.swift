//
//  NavigationItem.swift
//
//  Created by name on 26/04/2025.
//
import SwiftUI

public struct NavigationItem: Hashable {
    public let id: UUID
    public let destination: AnyView
    public let type: Any.Type
    
    // Initialize with a view
    public init<Content: View>(id: UUID = UUID(), destination: Content) {
        self.id = id
        self.destination = AnyView(destination)
        self.type = Content.self
    }
    
    // Implement hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Implement equality
    public static func == (lhs: NavigationItem, rhs: NavigationItem) -> Bool {
        lhs.id == rhs.id
    }
}
