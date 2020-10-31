import Foundation
@testable import Pokedex

class PokeListCoordinatorMock: PokeListCoordinatorProtocol {
    var startCount: Int = 0
    var startHandler: () -> Void = {}
    var showDetailCount: Int = 0
    var showDetailHandler: (PokePreview, Presenter, NetworkContextProtocol) -> Void = { _, _, _ in }
    
    func start() {
        startCount += 1
        startHandler()
    }
    
    func showDetail(preview: PokePreview, presenter: Presenter, network: NetworkContextProtocol) {
        showDetailCount += 1
        showDetailHandler(preview, presenter, network)
    }
}
