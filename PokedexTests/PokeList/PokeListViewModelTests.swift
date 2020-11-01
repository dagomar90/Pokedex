import XCTest
@testable import Pokedex

class PokeListViewModelTests: XCTestCase {
    var sut: PokeListViewModel!
    var network: NetworkMock!
    var coordinator: PokeListCoordinatorMock!

    override func setUpWithError() throws {
        network = NetworkMock()
        coordinator = PokeListCoordinatorMock()
        
        sut = PokeListViewModel(network: network, coordinator: coordinator)
    }
    
    func testLoad_success() {
        network.getPokemonListHandler = { completion in
            completion(.success(PokePreviewList.mock))
            return nil
        }
        
        sut.onError = { _ in XCTFail("It must not be called") }
        
        sut.load()
        
        XCTAssertEqual(network.getPokemonListCount, 1)
    }
    
    func testLoad_failure() {
        network.getPokemonListHandler = { completion in
            completion(.failure(MockError.mock))
            return nil
        }
        
        sut.onUpdate = { _ in XCTFail("It must not be called") }
        sut.onError = { XCTAssertEqual($0 as! MockError, MockError.mock) }
        
        sut.load()
        
        XCTAssertEqual(network.getPokemonListCount, 1)
    }
    
    func testLoadNext_withNilNext() {
        network.getPokemonListHandler = { completion in
            completion(.success(PokePreviewList.mock))
            return nil
        }
        sut.load()
        sut.loadNext(IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(network.getPokemonListWithUrlStringCount, 0)
    }
    
    func testLoadNext_withNotLastIndex() {
        network.getPokemonListHandler = { completion in
            completion(.success(PokePreviewList.withNext))
            return nil
        }
        sut.load()
        sut.loadNext(IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(network.getPokemonListWithUrlStringCount, 0)
    }
    
    func testLoadNext_success() {
        network.getPokemonListHandler = { completion in
            completion(.success(PokePreviewList.withNext))
            return nil
        }
        network.getPokemonListWithUrlHandler = { _, completion in
            completion(.success(PokePreviewList.mock))
            return nil
        }
        sut.load()
        sut.onError = { _ in XCTFail("It must not be called") }
        
        sut.loadNext(IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(network.getPokemonListWithUrlStringCount, 1)
    }
    
    func testLoadNext_failure() {
        network.getPokemonListHandler = { completion in
            completion(.success(PokePreviewList.withNext))
            return nil
        }
        network.getPokemonListWithUrlHandler = { _, completion in
            completion(.failure(MockError.mock))
            return nil
        }
        sut.load()
        sut.onUpdate = { _ in XCTFail("It must not be called") }
        sut.onError = { XCTAssertEqual($0 as! MockError, MockError.mock) }
        
        sut.loadNext(IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(network.getPokemonListWithUrlStringCount, 1)
    }
    
    func testNavigateToDetail() {
        sut.navigateToDetail(preview: PokePreview.mock, presenter: PresenterMock())
        
        XCTAssertEqual(coordinator.showDetailCount, 1)
    }
}
