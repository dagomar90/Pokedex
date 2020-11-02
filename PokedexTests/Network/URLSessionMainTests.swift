import XCTest
@testable import Pokedex

class URLSessionMainTests: XCTestCase {
    func testInitialization() {
        let sut = URLSession.main
        
        XCTAssertEqual(sut.configuration.requestCachePolicy, .returnCacheDataElseLoad)
        XCTAssertEqual(sut.configuration.urlCache?.memoryCapacity, 1024 * 1024 * 5)
        XCTAssertEqual(sut.configuration.urlCache?.diskCapacity, 1024 * 1024 * 200)
    }
}
