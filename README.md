# Drip

The Drip framework is a lightweight [dependency injection framework](https://en.wikipedia.org/wiki/Dependency_injection) (in terms of the API exposed to the client), has a relatively simple integration process (minimize XCode project modifications), easy to debug, and also robust, dealing gracefully with errors when they do arise. Lastly, well covered with unit testing. All this made with Swift for Swift.

<br>

## Getting Started

Drip primarily uses [SwiftPM](https://swift.org/package-manager/) as its build tool, so we recommend using that as well. If you want to depend on Drip in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Angel-Cortez/Drip", from: "0.0.1")
]
```

#  🚧 WARNING!: experimental implementation 🚧
- [x] Depedency Resoultion - functions, classes, and structs
- [ ] Code generation
- [ ] Circular Dependency detection
<br>

## Usage


### Defining basic Components
``` swift
// ^->RootComponent
class RootComponent: OmegaComponent {
    /// The singleton instance.
    public static let instance = RootComponent()
}
// ^->RootComponent->AComponent
class AComponent: Component {
    /// The singleton instance.
    public static let instance = AComponent(parent: RootComponent.instance)
}
```

### Providing Dependencies 
```swift
__Registry.instance.registerDependencyProviderFactory(for: AComponent.instance.get(NetworkManager.self)) {
    return NewNetworkManager() as AnyObject
}
```

###  Dependency Resolution in `class` or `struct` 
```swift
class ViewController {
    @Inject(AComponent.instance.get(NetworkManager.self))
    var manager: NetworkManager?
}
```
