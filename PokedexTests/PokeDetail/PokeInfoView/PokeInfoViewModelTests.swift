import XCTest
@testable import Pokedex

class PokeInfoViewModelTests: XCTestCase {
    var sut: PokeInfoViewModel!
    

    override func setUpWithError() throws {
        sut = PokeInfoViewModel.init(title: "Title", values: ["Value1", "Value2"])
    }
    
    func testPokeInfoRowViewModels() {
        let result = sut.pokeInfoRowViewModels
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].title, "Value1")
        XCTAssertEqual(result[1].title, "Value2")
    }
}
