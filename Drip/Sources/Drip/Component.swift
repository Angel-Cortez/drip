//
//  Component.swift
//  
//
//  Created by Angel Cortez on 11/14/21.
//

import Foundation

open class Component: Scope {
    /// The parent of this component.
    public let parent: Scope

    /// The path to reach this scope on the dependnecy graph.
    // Use `lazy var` to avoid computing the path repeatedly. Internally,
    // this is always accessed with the `__Registry`'s lock
    // acquired.
    public lazy var path: [String] = {
        let name = self.name
        return parent.path + ["->", "\(name)"]
    }()
    
    /// Utiltiy to compute path to dependency in the dependency graph.
    /// - parameter property: The name of the property of dependency
    public func get(_ property: String) -> String {
        return (path + [".",  property]).reduce("", +)
    }
    
    /// Utiltiy to compute path to dependency in the dependency graph.
    /// - parameter property: The name of the property of dependency
    public func get<T>(_ property: T.Type) -> String {
        let fullyQualifiedSelfName = String(describing: property)
        return (path + [".",  fullyQualifiedSelfName]).reduce("", +)
    }

    /// Initializer.
    ///
    /// - parameter parent: The parent component of this component.
    public init(parent: Scope) {
        self.parent = parent
    }
    
    // MARK: - Private
    private lazy var name: String = {
        let fullyQualifiedSelfName = String(describing: self)
        let parts = fullyQualifiedSelfName.components(separatedBy: ".")
        return parts.last ?? fullyQualifiedSelfName
    }()

}
