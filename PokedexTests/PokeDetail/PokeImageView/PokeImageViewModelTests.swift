import XCTest
@testable import Pokedex

class PokeImageViewModelTests: XCTestCase {
    var sut: PokeImageViewModel!
    var network: NetworkMock!

    override func setUpWithError() throws {
        network = NetworkMock()
        sut = PokeImageViewModel(url: "https://image_url",
                                 network: network)
    }
    
    func testLoad_success() {
        network.getPokemonImageHandler = { _, completion in
            completion(.success(Data()))
            return nil
        }
        sut.onError = { _ in XCTFail("it must not be called") }
        sut.onSuccess = { XCTAssertEqual($0, Data()) }
        sut.load()
    }
    
    func testLoad_failure() {
        network.getPokemonImageHandler = { _, completion in
            completion(.failure(MockError.mock))
            return nil
        }
        sut.onError = { XCTAssertEqual($0 as! MockError, MockError.mock) }
        sut.onSuccess = { _ in XCTFail("it must not be called") }
        sut.load()
    }
}
