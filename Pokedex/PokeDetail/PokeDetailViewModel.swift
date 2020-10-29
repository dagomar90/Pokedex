import Foundation

class PokeDetailViewModel {
    let preview: PokePreview
    let network: NetworkContextProtocol
    
    private var detail: PokeDetail?
    
    var onUpdate: () -> Void = {}
    var onError: (Error) -> Void = { _ in }
    
    var name: String {
        detail.map({ $0.name }).orEmpty
    }
        
    var baseExperience: String {
        detail.map({ "BASE EXP: \($0.base_experience)" }).orEmpty
    }
    
    var height: String {
        detail.map({ "HEIGHT: \($0.height * 10) cm" }).orEmpty
    }
    
    var weight: String {
        detail.map({ "WEIGHT: \($0.weight)" }).orEmpty
    }
    
    var images: [String] {
        [detail?.sprites.front_default,
         detail?.sprites.back_default,
         detail?.sprites.front_female,
         detail?.sprites.back_female,
         detail?.sprites.front_shiny,
         detail?.sprites.back_shiny,
         detail?.sprites.front_shiny_female,
         detail?.sprites.back_shiny_female].compactMap({ $0 })
    }
    
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
        self.detail = detail
        onUpdate()
    }
    
    private func onFailure(_ error: Error) {
        onError(error)
    }
}
