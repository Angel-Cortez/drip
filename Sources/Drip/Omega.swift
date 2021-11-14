//
//  OmegaComponent.swift
//  
//
//  Created by Angel Cortez on 11/14/21.
//

import Foundation

/// The base implementation of a component thet represents the root of
/// a dependency graph. A subclass defining the root scope should
/// inherit from this class instead of the generic `Component` class.
///
/// - SeeAlso: `Component`.
open class OmegaComponent: Component {

    /// Initializer.
    public init() {
        super.init(parent: BigBang())
    }

    // MARK: - Private
    private class BigBang: Scope {
        fileprivate let path: [String] = ["^"]
        /// This component does not have a parent. Do not access this property.
        fileprivate var parent: Scope {
            // With properly generated Drip code, this property should never
            // be accessed.
            fatalError("OmegaComponent does not have a parent, do not use this property.")
        }

        fileprivate init() {}
    }
}
