import Foundation

class PokeListSearchBarViewModel {
    private let network: NetworkContextProtocol
    
    var onGo: (String, String) -> Void = { _, _ in }
    var onSearchBarUpdates: () -> Void = {}
    var onTextFieldShouldReturn: () -> Void = {}
    var onScroll: () -> Void = {}
    var onPokemonSelection: () -> Void = {}
    
    init(network: NetworkContextProtocol) {
        self.network = network
    }
    
    var goButtonTitle: String {
        "Go"
    }
    
    var placeholder: String {
        "Search your Pokemon"
    }
    
    func textFieldShouldReturn() -> Bool {
        onTextFieldShouldReturn()
        return true
    }
    
    func goAction(name: String) {
        guard !name.isEmpty else { return }
        let lowercasedName = name.lowercased()
        let url = network.configuration.baseUrl + "/api/v2/pokemon/" + lowercasedName
        onGo(lowercasedName, url)
        onSearchBarUpdates()
    }
    
    func scroll() {
        onScroll()
    }
    
    func pokemonSelected() {
        onPokemonSelection()
    }
}
