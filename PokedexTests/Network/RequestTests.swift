import XCTest
@testable import Pokedex

class RequestTests: XCTestCase {
    var sut: Request!
    var task: UrlSessionDataTaskMock!
    var uuid: UUID!
    var imagesCache: ImagesCacheMock!
    
    override func setUpWithError() throws {
        task = UrlSessionDataTaskMock()
        uuid = UUID(uuidString: "28732f47-e71c-4c11-9492-68f6e7125bed")
        imagesCache = ImagesCacheMock()
        sut = Request(task: task, uuid: uuid, imagesCache: imagesCache)
    }
    
    func testCancel() {
        sut.cancel()
        
        XCTAssertEqual(task.cancelCount, 1)
        XCTAssertEqual(imagesCache.removeRequestCount, 1)
    }
    
    func testExecute() {
        sut.execute()
        
        XCTAssertEqual(task.resumeCount, 1)
        XCTAssertEqual(imagesCache.storeRequestCount, 1)
    }
}
