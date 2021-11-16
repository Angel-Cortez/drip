//
//  DependencyGraph.swift
//  HelloWorld
//
//  Created by Angel Cortez on 11/15/21.
//

import Drip

// ^->RootComponent
class RootComponent: OmegaComponent {
    /// The singleton instance.
    public static let instance = RootComponent()
}
// ^->RootComponent->MainComponent
class MainComponent: Component {
    /// The singleton instance.
    public static let instance = MainComponent(parent: RootComponent.instance)
}
