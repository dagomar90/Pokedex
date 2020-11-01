import Foundation
@testable import Pokedex

class URLSessionMock: UrlSessionProtocol {
    var dataTaskWithUrlCompletionHandlerCount: Int = 0
    var dataTaskWithUrlCompletionHandlerHandler: (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> UrlSessionDataTaskProtocol = { _, _ in UrlSessionDataTaskMock() }
    
    func dataTask(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> UrlSessionDataTaskProtocol {
        dataTaskWithUrlCompletionHandlerCount += 1
        return dataTaskWithUrlCompletionHandlerHandler(url, completionHandler)
    }
}
