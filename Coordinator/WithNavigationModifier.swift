//
//  WithNavigationModifier.swift
//
//  Created by name on 26/04/2025.
//
import SwiftUI

//MARK: - WithNavigationModifier

/// A view modifier that adds coordinator to a view.

public struct WithNavigationModifier: ViewModifier {
    @StateObject private var coordinator = Coordinator()
    
    /// Applies the coordinator to the view.
    ///
    /// This method wraps the content view inside a `NavigationStack` and uses a `NavigationManager` to manage the navigation path. The `NavigationItem` instances in the path are mapped to their respective destinations.
    /// - Parameter content: The content view to apply the modifier to.
    /// - Returns: A view wrapped in a `NavigationStack` with a navigation manager.
    public func body(content: Content) -> some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: NavigationItem.self) {item in
                    item.destination
                }
        }
        .environmentObject(coordinator)
    }
}

extension View {
    /// Adds navigation functionality to a view using `WithNavigationModifier`.
    ///
    /// This method applies the `WithNavigationModifier` to the view, enabling navigation features like managing the navigation stack and destinations.
    /// - Returns: A view with navigation management applied.
    public func withNavigation() -> some View {
        modifier(WithNavigationModifier())
    }
}
