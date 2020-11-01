import XCTest
@testable import Pokedex

class PokeDetailViewModelTests: XCTestCase {
    var sut: PokeDetailViewModel!
    var network: NetworkMock!

    override func setUpWithError() throws {
        network = NetworkMock()
        sut = PokeDetailViewModel(preview: PokePreview.mock, network: network)
    }
    
    func testName() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.name
        XCTAssertEqual(result, "Name")
    }
    
    func testBaseExperience() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.baseExperience
        XCTAssertEqual(result, "BASE EXP: 12 pt")
    }
    
    func testHeight() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.height
        XCTAssertEqual(result, "HEIGHT: 340 cm")
    }
    
    func testWeight() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.weight
        XCTAssertEqual(result, "WEIGHT: 22 kg")
    }
    
    func testImages() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.imageViewModels
        XCTAssertEqual(result.map({ $0.url }), ["http://front_default",
                                                "http://back_default",
                                                "http://front_female",
                                                "http://back_female",
                                                "http://front_shiny",
                                                "http://back_shiny",
                                                "http://front_shiny_female",
                                                "http://back_shiny_female"])
    }
    
    func testAbilityViewModel() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.abilitityViewModel
        XCTAssertEqual(result.title, "ABILITIES")
        XCTAssertEqual(result.values, ["ABILITY", "ABILITY"])
    }
    
    func testAbilityViewModel_NilDetail() {
        let result = sut.abilitityViewModel
        XCTAssertEqual(result.title, "ABILITIES")
        XCTAssertEqual(result.values, [])
    }
    
    func testStatViewModel_NilDetail() {
        let result = sut.statViewModel
        XCTAssertEqual(result.title, "STATS")
        XCTAssertEqual(result.values, [])
    }
    
    func testTypeViewModel_NilDetail() {
        let result = sut.typeViewModel
        XCTAssertEqual(result.title, "TYPES")
        XCTAssertEqual(result.values, [])
    }
    
    func testStatViewModel() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.statViewModel
        XCTAssertEqual(result.title, "STATS")
        XCTAssertEqual(result.values, ["STAT: 72"])
    }
    
    func testTypeViewModel() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.load()
        
        let result = sut.typeViewModel
        XCTAssertEqual(result.title, "TYPES")
        XCTAssertEqual(result.values, ["TYPE"])
    }
    
    func testLoad_success() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.success(PokeDetail.mock))
            return nil
        }
        sut.onError = { _ in XCTFail("it must not be called") }
        sut.load()
    }
    
    func testLoad_failure() {
        network.getPokemonDetailHandler = { _, completion in
            completion(.failure(MockError.mock))
            return nil
        }
        sut.onError = { XCTAssertEqual($0 as! MockError, MockError.mock) }
        sut.onUpdate = { XCTFail("it must not be called") }
        sut.load()
    }
}
