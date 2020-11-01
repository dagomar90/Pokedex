import XCTest
@testable import Pokedex

class PokeDetailCoordinatorTests: XCTestCase {
    var sut: PokeDetailCoordinator!
    var presenter: PresenterMock!
    var network: NetworkMock!

    override func setUpWithError() throws {
        presenter = PresenterMock()
        network = NetworkMock()
        sut = PokeDetailCoordinator(preview: PokePreview.mock,
                                    presenter: presenter,
                                    network: network)
    }
    
    func testStart() {
        presenter.presentHandler = { controller in
            XCTAssertTrue(controller is PokeDetailViewController)
        }
        sut.start()
        XCTAssertEqual(presenter.presentCount, 1)
    }
}
