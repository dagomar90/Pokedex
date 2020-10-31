import XCTest
@testable import Pokedex

class PokeListCellViewModelTests: XCTestCase {
    var sut: PokeListCellViewModel!
    var network: NetworkMock!
    
    override func setUpWithError() throws {
        network = NetworkMock()
        sut = PokeListCellViewModel(network: network, preview: PokePreview.mock, onSelect: { _ in })
    }
    
    func testName() {
        let result = sut.name
        XCTAssertEqual(result, "MockName")
    }
    
    func testUrl() {
        let result = sut.url
        XCTAssertEqual(result, "MockUrl")
    }
    
    func testPlaceholderName() {
        let result = sut.placeholderName
        XCTAssertEqual(result, "Placeholder")
    }
    
    func testSelect() {
        sut.onSelect = { preview in
            XCTAssertEqual(preview.name, "MockName")
            XCTAssertEqual(preview.url, "MockUrl")
        }
        sut.select()
    }
    
    func testLoadImage_failure() {
        network.getPokemonImageHandler = { string, completion in
            completion(Result.failure(MockError.mock))
            return nil
        }
        
        sut.onSuccess = { _ in XCTFail("It must not be called") }
        sut.onFailure = { XCTAssertEqual($0 as! MockError, MockError.mock) }
        
        sut.loadImage()
        
        XCTAssertEqual(network.getPokemonImageCount, 1)
    }
    
    func testLoadImage_success() {
        network.getPokemonImageHandler = { string, completion in
            completion(Result.success(Data()))
            return nil
        }
        
        sut.onSuccess = { XCTAssertEqual($0, Data()) }
        sut.onFailure = { _ in XCTFail("It must not be called") }
        
        sut.loadImage()
        
        XCTAssertEqual(network.getPokemonImageCount, 1)
    }
    
    func testLoadImage_wrongUrlFailure() {
        sut = PokeListCellViewModel(network: network, preview: PokePreview.wrongUrl, onSelect: { _ in })
        
        sut.onSuccess = { _ in XCTFail("It must not be called") }
        sut.onFailure = { _ in XCTFail("It must not be called") }
        
        sut.loadImage()
        
        XCTAssertEqual(network.getPokemonImageCount, 0)
    }
}
