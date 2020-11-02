import XCTest
@testable import Pokedex

class PokeListSearchBarViewModelTests: XCTestCase {
    var sut: PokeListSearchBarViewModel!
    var network: NetworkMock!
    
    override func setUpWithError() throws {
        network = NetworkMock()
        sut = PokeListSearchBarViewModel(network: network)
    }
    
    func testGoButtonTitle() {
        let result = sut.goButtonTitle
        
        XCTAssertEqual("Go", result)
    }
    
    func testPlaceholder() {
        let result = sut.placeholder
        
        XCTAssertEqual("Search your Pokemon", result)
    }
    
    func testTextFieldShouldReturn_returnsTrue() {
        let result = sut.textFieldShouldReturn()
        
        XCTAssertTrue(result)
    }
    
    func testTextFieldShouldReturn_callsFunction() {
        var functionNumCalls = 0
        sut.onTextFieldShouldReturn = { functionNumCalls += 1 }
        _ = sut.textFieldShouldReturn()
        
        XCTAssertEqual(functionNumCalls, 1)
    }
    
    func testGoAction_withEmptyName() {
        var onGoCallsCount = 0
        var onSearchBarUpdatesCount = 0
        sut.onGo = { _, _ in onGoCallsCount += 1 }
        sut.onSearchBarUpdates = { onSearchBarUpdatesCount += 1 }
        
        sut.goAction(name: "")
        
        XCTAssertEqual(onGoCallsCount, 0)
        XCTAssertEqual(onSearchBarUpdatesCount, 0)
    }
    
    func testGoAction_withNotEmptyName() {
        var onGoCallsCount = 0
        var onSearchBarUpdatesCount = 0
        sut.onGo = { name, url in
            onGoCallsCount += 1
            XCTAssertEqual(name, "mewtwo")
            XCTAssertEqual(url, "http://test_url/api/v2/pokemon/mewtwo")
        }
        sut.onSearchBarUpdates = { onSearchBarUpdatesCount += 1 }
        
        sut.goAction(name: "Mewtwo")
        
        XCTAssertEqual(onGoCallsCount, 1)
        XCTAssertEqual(onSearchBarUpdatesCount, 1)
    }
    
    func testScroll() {
        var functionNumCalls = 0
        sut.onScroll = { functionNumCalls += 1 }
        
        sut.scroll()
        
        XCTAssertEqual(functionNumCalls, 1)
    }
    
    func testPokemonSelected() {
        var functionNumCalls = 0
        sut.onPokemonSelection = { functionNumCalls += 1 }
        
        sut.pokemonSelected()
        
        XCTAssertEqual(functionNumCalls, 1)
    }
}
