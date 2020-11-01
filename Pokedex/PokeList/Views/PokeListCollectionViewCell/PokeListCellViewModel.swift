import Foundation

class PokeListCellViewModel {
    let network: NetworkContextProtocol
    let preview: PokePreview
    
    var onSelect: (PokePreview) -> Void = { _ in }
    var onSuccess: (Data) -> Void = { _ in }
    var onFailure: (Error) -> Void = { _ in }
    
    private var request: Request?
    
    init(network: NetworkContextProtocol, preview: PokePreview, onSelect: @escaping (PokePreview) -> Void) {
        self.network = network
        self.preview = preview
        self.onSelect = onSelect
    }
    
    var name: String {
        preview.name
    }
    
    var url: String {
        preview.url
    }
    
    var placeholderName: String {
        "Placeholder"
    }
    
    func select() {
        onSelect(preview)
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    func loadImage() {
        guard let identifier = url.components(separatedBy: "/").filter({ !$0.isEmpty }).last else { return }
        request = network.getPokemonImage(with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(identifier).png", completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.onSuccess(data)
            case let .failure(error):
                self?.onFailure(error)
            }
        })
        request?.execute()
    }
}
