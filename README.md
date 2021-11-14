# Drip

The Drip framework is lightweight (in terms of the API exposed to the client), has a relatively simple integration process (minimize XCode project modifications), easy to debug, and also robust, dealing gracefully with errors when they do arise. Lastly, well covered with unit testing. All this made with Swift for Swift.

<br>

## Getting Started

Drip primarily uses [SwiftPM](https://swift.org/package-manager/) as its build tool, so we recommend using that as well. If you want to depend on Drip in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/acort3255/Drip", from: "1.0.0")
]
```

#  🚧 WARNING!: experimental implementation 🚧
- [x] Depedency Resoultion - functions, classes, and structs
- [ ] Code generation
- [ ] Circular Dependency detection
<br>

## Usage

For convenience you can declare with your class or struct:

```swift
@Inject(name: AComponent.instance.get(NetworkManager.self))
var manager: NetworkManager?
```
