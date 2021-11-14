import XCTest
@testable import Drip

final class DripTests: XCTestCase {
    override func setUp() {
        super.setUp()
        registerProviderFactories()
    }
    
    override func tearDown() {
        super.tearDown()
        unregisterProviderFactories()
    }
    
    func test_new_instance_per_request() throws {
 
        let videoPlayerController1 = VideoPlayerController()
        let videoPlayerController2 = VideoPlayerController()
        
        XCTAssertTrue(videoPlayerController1.videoPlayer !== videoPlayerController2.videoPlayer)
    }
    
    func test_registry_verify_same_reference() throws {
 
        let expectedClass = MockClass()
        __Registry.instance.registerDependencyProviderFactory(for: BComponent.instance.get(MockClass.self)) {
            return expectedClass as AnyObject
        }
        
        let mockDependency = MockDependentClass()
        XCTAssertTrue(mockDependency.dependency === expectedClass)
    }
    
    func registerProviderFactories() {
        __Registry.instance.registerDependencyProviderFactory(for: RootComponent.instance.get("View")) {
            return "Drip App Name" as AnyObject
        }
        
        __Registry.instance.registerDependencyProviderFactory(for: BComponent.instance.get(VideoPlayer.self)) {
            return LegacyPlayerProvider() as AnyObject
        }
        
        __Registry.instance.registerDependencyProviderFactory(for: AComponent.instance.get("View")) {
            return ({ print("New View") }) as AnyObject
        }
        
        __Registry.instance.registerDependencyProviderFactory(for: BComponent.instance.get("View")) {
            return ({ print("Legacy View") }) as AnyObject
        }
    }
    
    func unregisterProviderFactories() {
        __Registry.instance.unregisterDependencyProviderFactory(for: RootComponent.instance.get("View"))
        
        __Registry.instance.unregisterDependencyProviderFactory(for: BComponent.instance.get(VideoPlayer.self))
        
        __Registry.instance.unregisterDependencyProviderFactory(for: AComponent.instance.get("View"))
        
        __Registry.instance.unregisterDependencyProviderFactory(for: BComponent.instance.get("View"))
    }
}

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
// ^->RootComponent->AComponent->BComponent
class BComponent: Component {
    /// The singleton instance.
    public static let instance = BComponent(parent: AComponent.instance)
}

protocol VideoPlayer: AnyObject {
    var id: String { get }
    var view: () -> Void { get }
}

class LegacyPlayerProvider: VideoPlayer {
    let id = "com.nbc.player.legacy"
    
    @Inject(BComponent.instance.get("View"))
    var view: () -> Void
}



class NewPlayerProvider: VideoPlayer {
    let id = "com.nbc.player.new"
    
    @Inject(AComponent.instance.get("View"))
    var view: () -> Void
}

class VideoPlayerController {
    @Inject(BComponent.instance.get(VideoPlayer.self))
    var videoPlayer: VideoPlayer
}

class MockClass {}
class MockDependentClass {
    @Inject(BComponent.instance.get(MockClass.self))
    var dependency: MockClass?
}
