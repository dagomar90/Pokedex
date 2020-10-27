import Foundation

class PokeListViewModel {
    private let network = NetworkContext()
    private(set) var viewModels: [PokeListCellViewModel] = []
    var onUpdate: () -> Void = {}
    var onError: (Error) -> Void = { _ in }
    
    func load() {
        network.getPokemonList(completion: { result in
            switch result {
            case let .success(list):
                loadSucceeded(list)
            case let .failure(error):
                loadFailed(error)
            }
        })
    }
    
    private func loadSucceeded(_ result: [PokePreview]) {
        viewModels = result.map(PokeListCellViewModel.init)
        onUpdate()
    }
    
    private func loadFailed(_ error: Error) {
        onError(error)
    }
}
