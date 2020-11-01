import XCTest
@testable import Pokedex

class ImagesCacheTests: XCTestCase {
    var sut: ImagesCache!

    override func setUpWithError() throws {
        sut = ImagesCache.init(loadedImages: [URL(string: "http://test")!: Data()],
                               runningRequests: [UUID(uuidString: "3c581ed4-1c7e-11eb-adc1-0242ac120002")!: UrlSessionDataTaskMock()])
    }
    
    func testGetImage() {
        let result = sut.getImage(with: URL(string: "http://test")!)
        XCTAssertEqual(Data(), result)
    }
    
    func testStoreImage() {
        sut.storeImage(with: URL(string: "http://test2")!, data: Data())
        
        XCTAssertNotNil(sut.loadedImages[URL(string: "http://test2")!])
    }
    
    func testStoreRequest() {
        sut.store(Request(task: UrlSessionDataTaskMock(), uuid: UUID(uuidString: "fa9f7bb2-1c7e-11eb-adc1-0242ac120002")!))
        
        XCTAssertNotNil(sut.runningRequests[UUID(uuidString: "fa9f7bb2-1c7e-11eb-adc1-0242ac120002")!])
    }
    
    func testRemoveRequest() {
        sut.remove(Request.init(task: UrlSessionDataTaskMock(), uuid: UUID(uuidString: "3c581ed4-1c7e-11eb-adc1-0242ac120002")!))
        XCTAssertEqual(sut.runningRequests.count, 0)
    }
    
    func testRemoveUUID() {
        sut.remove(UUID(uuidString: "3c581ed4-1c7e-11eb-adc1-0242ac120002")!)
        XCTAssertEqual(sut.runningRequests.count, 0)
    }
}
