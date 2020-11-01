import Foundation

struct Request: Cancellable {
    let task: UrlSessionDataTaskProtocol
    
    func cancel() {
        task.cancel()
    }
    
    func execute() {
        task.resume()
    }
}
