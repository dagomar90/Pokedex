import Foundation
@testable import Pokedex

class DispatcherMock: Dispatcher {
    var dispatchCount: Int = 0
    var dispatchHandler: (() -> Void) -> Void = { _ in }
    
    func dispatch(_ function: @escaping () -> Void) {
        dispatchCount += 1
        dispatchHandler(function)
    }
}
