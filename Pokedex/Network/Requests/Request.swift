import Foundation

struct Request: Cancellable {
    let task: URLSessionTask
    
    func cancel() {
        task.cancel()
    }
    
    func execute() {
        task.resume()
    }
}
