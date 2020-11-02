import Foundation

class PokeListViewModel {
    private let network: NetworkContextProtocol
    private let coordinator: PokeListCoordinatorProtocol
    private(set) var viewModels: [PokeListCellViewModel] = []
    let searchBarViewModel: PokeListSearchBarViewModel
    private var next: String?
    
    var onUpdate: ([IndexPath]) -> Void = { _ in }
    var onError: (Error) -> Void = { _ in }
    var onSelect: (PokePreview) -> Void = { _ in }
    
    init(network: NetworkContextProtocol,
         coordinator: PokeListCoordinatorProtocol) {
        self.network = network
        self.coordinator = coordinator
        self.searchBarViewModel = PokeListSearchBarViewModel(network: network)
    }
    
    func load() {
        network.getPokemonList(completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })?.execute()
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
        })?.execute()
    }
    
    private func loadSucceeded(_ result: PokePreviewList) {
        let paths = Array(viewModels.count..<(viewModels.count + result.results.count))
            .map({ IndexPath(row: $0, section: 0) })
        
        viewModels = viewModels + result
            .results
            .map({ PokeListCellViewModel.init(network: network,
                                              preview: $0,
                                              onSelect: { [weak self] in self?.onSelect($0) }) })
        next = result.next
        onUpdate(paths)
    }
    
    private func loadFailed(_ error: Error) {
        onError(error)
    }
}

extension PokeListViewModel {
    func navigateToDetail(preview: PokePreview, presenter: Presenter) {
        coordinator.showDetail(preview: preview,
                               presenter: presenter,
                               network: network)
    }
}
