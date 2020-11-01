import Foundation
@testable import Pokedex

class ImagesCacheMock: ImagesCacheProtocol {
    var getImageWithUrlCount: Int = 0
    var getImageWithUrlHandler: (URL) -> Data? = { _ in nil }
    var storeImageWithUrlDataCount: Int = 0
    var storeImageWithUrlDataHandler: (URL, Data) -> Void = { _, _ in }
    var storeRequestCount: Int = 0
    var storeRequestHandler: (Request) -> Void = { _ in }
    var removeRequestCount: Int = 0
    var removeRequestHandler: (Request) -> Void = { _ in }
    var removeUUIDCount: Int = 0
    var removeUUIDHandler: (UUID) -> Void = { _ in }
        
    func getImage(with url: URL) -> Data? {
        getImageWithUrlCount += 1
        return getImageWithUrlHandler(url)
    }
    
    func storeImage(with url: URL, data: Data) {
        storeImageWithUrlDataCount += 1
        storeImageWithUrlDataHandler(url, data)
    }
    
    func store(_ request: Request) {
        storeRequestCount += 1
        storeRequestHandler(request)
    }
    
    func remove(_ request: Request) {
        removeRequestCount += 1
        removeRequestHandler(request)
    }
    
    func remove(_ uuid: UUID) {
        removeUUIDCount += 1
        removeUUIDHandler(uuid)
    }
}
