import XCTest
@testable import Pokedex

class PokeListCoordinatorTests: XCTestCase {
    var sut: PokeListCoordinator!
    var presenter: PresenterMock!
    var network: NetworkMock!

    override func setUpWithError() throws {
        presenter = PresenterMock()
        network = NetworkMock()
        sut = PokeListCoordinator(presenter: presenter, network: network)
    }
    
    func testStart() {
        presenter.presentHandler = { controller in
            guard let controller = controller as? UINavigationController else {
                XCTFail("controller must be UINavigationController")
                return
            }
            XCTAssertTrue(controller.topViewController is PokeListViewController)
        }
        sut.start()
        XCTAssertEqual(presenter.presentCount, 1)
    }
}
