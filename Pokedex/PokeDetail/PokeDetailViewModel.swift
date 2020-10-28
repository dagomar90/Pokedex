import Foundation

class PokeDetailViewModel {
    let preview: PokePreview
    let network: NetworkContextProtocol
    
    init(preview: PokePreview, network: NetworkContextProtocol) {
        self.preview = preview
        self.network = network
    }
    
    func load() {
        network.getPokemonDetail(with: preview.url,
                                 completion: { [weak self] result in
                                    switch result {
                                    case let .success(detail):
                                        self?.onSuccess(detail)
                                    case let .failure(error):
                                        self?.onError(error)
                                    }
                                 })?.execute()
    }
    
    private func onSuccess(_ detail: PokeDetail) {
        print("detail: \(detail)")
    }
    
    private func onError(_ error: Error) {
        
    }
}
