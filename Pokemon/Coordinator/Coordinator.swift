//
//  Coordinator.swift
//
//  Created by name on 26/04/2025.
//

import SwiftUI

final public class Coordinator: ObservableObject {
    @Published public var path: [NavigationItem] = []
}

// MARK: - Push

extension Coordinator {
    
    /// Pushes a navigation item onto the path when you have an identifier.
    ///
    /// This method allows you to push a `NavigationItem` directly onto the path if you already have the navigation item's ID.
    /// - Parameter navigationItem: The navigation item to push onto the path.
    public func push(_ navigationItem: NavigationItem) {
        path.append(navigationItem)
    }
    
    /// Pushes a navigation item without an identifier, using a view builder.
    ///
    /// This method allows you to create a `NavigationItem` dynamically using a view builder. The destination view is provided as a closure and pushed onto the path.
    /// - Parameter destination: A view builder closure that returns the destination view to be pushed.
    public func push<Content: View>(@ViewBuilder destination: @escaping () -> Content) {
        let navigationItem = NavigationItem(destination: destination())
        path.append(navigationItem)
    }
    
    /// Pushes multiple navigation items onto the path when you have identifiers for each.
    ///
    /// This method allows you to push multiple `NavigationItem`s onto the path at once by iterating over an array of navigation items.
    /// - Parameter navigationItems: An array of navigation items to push onto the path.
    public func push(_ navigationItems: [NavigationItem]) {
        for navigationItem in navigationItems {
            push(navigationItem)
        }
    }
    
    /// Pushes multiple navigation items without identifiers, using a view builder.
    ///
    /// This method allows you to create multiple `NavigationItem`s dynamically using a view builder. The destination views are provided as a closure, iterated over, and pushed onto the path.
    /// - Parameter destination: A closure that returns an array of destination views to be pushed.
    public func push<Content: View>(destination: @escaping () -> [Content]) {
        for item in destination() {
            push { item }
        }
    }
}

// MARK: - Pop

extension Coordinator {
    
    /// Removes one or more items from the path.
    ///
    /// This method removes a specified number of items from the end of the path. By default, it removes one item, but you can pass a custom count to remove more.
    /// - Parameter count: The number of items to remove from the path (default is 1).
    public func pop(count: Int = 1) {
        if !path.isEmpty {
            path.removeLast(count)
        }
    }
    
    /// Removes all items from the path, returning to the root view.
    ///
    /// This method removes all items in the path, essentially resetting the navigation stack and returning to the root view.
    public func popToRoot() {
        pop(count: path.count)
    }
    
    /// Removes all views until a specified view is found in the stack.
    ///
    /// This method removes all items from the path until the specified view is found. It looks for the last occurrence of the specified view type in the navigation stack and pops all items above it.
    /// - Parameter view: The view to pop to, identified by its type. The stack is truncated until this view is at the top.
    public func popToView<Content: View>(view: Content) {
        if let count = path
            .map({ $0.type })
            .lastIndex(where: { $0.self == Content.self })
            .map({ path.count - 1 - $0 }) {
            pop(count: count)
        }
    }
}
