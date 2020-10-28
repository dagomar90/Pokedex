import Foundation

class PokeDetailViewModel {
    let preview: PokePreview
    let network: NetworkContextProtocol
    
    init(preview: PokePreview, network: NetworkContextProtocol) {
        self.preview = preview
        self.network = network
    }
    
    func load() {
        // laod detail
    }
}
