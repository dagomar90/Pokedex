import Foundation
@testable import Pokedex

class UrlSessionDataTaskMock: UrlSessionDataTaskProtocol {
    var resumeCount: Int = 0
    var resumeHandler: () -> Void = {}
    var cancelCount: Int = 0
    var cancelHandler: () -> Void = {}
    
    func resume() {
        resumeCount += 1
        resumeHandler()
    }
    
    func cancel() {
        cancelCount += 1
        cancelHandler()
    }
}
