import Foundation

extension URLResponse {
    static var notFound: URLResponse {
        HTTPURLResponse(url: URL(string: "https://test")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    }
}
