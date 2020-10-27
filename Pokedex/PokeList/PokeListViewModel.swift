import Foundation

class PokeListViewModel {
    private let network = NetworkContext()
    private(set) var viewModels: [PokeListCellViewModel] = []
    private var next: String?
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
    
    func loadNext(_ indexPath: IndexPath) {
        guard let next = next else { return }
        guard indexPath.row == viewModels.count - 1 else { return }
        
        network.getPokemonList(with: next, completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })
    }
    
    private func loadSucceeded(_ result: PokePreviewList) {
        viewModels = viewModels + result.results.map(PokeListCellViewModel.init)
        next = result.next
        onUpdate()
    }
    
    private func loadFailed(_ error: Error) {
        onError(error)
    }
}
