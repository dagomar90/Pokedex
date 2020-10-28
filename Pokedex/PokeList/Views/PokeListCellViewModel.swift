import Foundation

struct PokeListCellViewModel {
    private let network = NetworkContext()
    let preview: PokePreview
    var onSelect: (PokePreview) -> Void = { _ in }
    var onSuccess: (Data) -> Void = { _ in }
    var onFailure: (Error) -> Void = { _ in }
    
    var name: String {
        preview.name
    }
    
    var url: String {
        preview.url
    }
    
    func select() {
        onSelect(preview)
    }
    
    func loadImage() {
        guard let identifier = url.components(separatedBy: "/").filter({ !$0.isEmpty }).last else { return }
        network.getPokemonImage(with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(identifier).png", completion: { result in
            switch result {
            case let .success(data):
                onSuccess(data)
            case let .failure(error):
                onFailure(error)
            }
        })
    }
}
