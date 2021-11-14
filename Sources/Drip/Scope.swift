//
//  Scope.swift
//  
//
//  Created by Angel Cortez on 11/13/21.
//

import Foundation


/// The base protocol of a DI scope. Application code should inherit
/// from the `Component` base class, instead of using this protocol
/// directly.
public protocol Scope: AnyObject {
    /// The path to reach this component on the dependnecy graph.
    var path: [String] { get }

    /// The parent of this component.
    var parent: Scope { get }
}
