//
//  DependencyRegistry.swift
//  HelloWorld
//
//  Created by Angel Cortez on 11/15/21.
//

import Drip
import Foundation
import UIKit

func registerDependencyFactories() {
    __Registry.instance.registerDependencyProviderFactory(for: RootComponent.instance.get("clientID"), { return UUID().uuidString as AnyObject })
    
    __Registry.instance.registerDependencyProviderFactory(for: MainComponent.instance.get("clientID"), { return __Registry.instance.dependencyProvider(for: RootComponent.instance.get("clientID")) })
    
    __Registry.instance.registerDependencyProviderFactory(for: MainComponent.instance.get("backgroundColor"), { return UIColor.systemMint as AnyObject })
    
    __Registry.instance.registerDependencyProviderFactory(for: MainComponent.instance.get("ranColor"), { return { return UIColor.random() }  as AnyObject })
}
