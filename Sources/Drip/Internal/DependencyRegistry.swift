//
//  DependencyRegistry.swift
//  
//
//  Created by Angel Cortez on 11/13/21.
//

import Foundation

/// Drip internal registry of dependency providers.
public class __Registry {

    /// The singleton instance.
    public static let instance = __Registry()

    /// Register the given factory closure with given key.
    ///
    /// - note: This method is thread-safe.
    /// - parameter componentPath: The dependency graph path of the component
    /// the provider is for.
    /// - parameter dependencyProviderFactory: The closure that takes in a
    /// component to be injected and returns a provider instance that conforms
    /// to the component's dependency protocol.
    public func registerDependencyProviderFactory(`for` componentPath: String, _ dependencyProviderFactory: @escaping () -> AnyObject) {
        providerFactoryLock.lock()
        defer {
            providerFactoryLock.unlock()
        }

        providerFactories[componentPath.hashValue] = dependencyProviderFactory
    }

    /// Unregister the given factory closure with given key.
    ///
    /// - note: This method is thread-safe.
    /// - parameter componentPath: The dependency graph path of the component
    /// the provider is for.
    public func unregisterDependencyProviderFactory(`for` componentPath: String) {
        providerFactoryLock.lock()
        defer {
            providerFactoryLock.unlock()
        }
        providerFactories.removeValue(forKey: componentPath.hashValue)
    }
    
    /// Retrieve the dependency provider for the given component and its parent.
    /// - note: This method is thread-safe.
    /// - parameter component: The component that uses the returned dependency provider.
    /// - returns: The dependency provider for the given component.
    public func dependencyProvider(`for` component: String) -> AnyObject {
        providerFactoryLock.lock()
        defer {
            providerFactoryLock.unlock()
        }

        let pathString = component
        if let factory = providerFactories[pathString.hashValue] {
            return factory()
        } else {
            // This case should never occur with properly generated factory code.
            // This is useful for Drip generator development only.
            fatalError("Missing dependency provider factory for \(component)")
        }
    }
    
    // MARK: - Internal

    private let providerFactoryLock = NSRecursiveLock()
    private var providerFactories = [Int: () -> AnyObject]()

    private init() {}
}
