//
//  Inject.swift
//  
//
//  Created by Angel Cortez on 11/13/21.
//

import Foundation

/// A  property wrapper to set and get system's environment variables values.
///
/// ```
/// @Inject(name: AComponent.instance.get(NetworkManager.self))
/// var manager: NetworkManager?
/// ```
///
@propertyWrapper
public struct Inject<T> {
    private let component: String
    public var wrappedValue: T {
        get { return __Registry.instance.dependencyProvider(for: component) as! T }
    }
    
    public init(_ component: String) {
        self.component = component
    }
}
