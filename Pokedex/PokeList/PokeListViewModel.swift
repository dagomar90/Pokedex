import Foundation

class PokeListViewModel {
    private let network = NetworkContext()
    private(set) var viewModels: [PokeListCellViewModel] = []
    var onUpdate: () -> Void = {}
    var onError: (Error) -> Void = { _ in }
    
    func load() {
        network.getPokemonList(completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })
    }
    
    private func loadSucceeded(_ result: PokePreviewList) {
        viewModels = result.results.map(PokeListCellViewModel.init)
        onUpdate()
    }
    
    private func loadFailed(_ error: Error) {
        onError(error)
    }
}
