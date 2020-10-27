import Foundation

class PokeListViewModel {
    private(set) var viewModels: [PokeListCellViewModel] = []
    var onUpdate: () -> Void = {}
    var onError: (Error) -> Void = { _ in }
    
    func load() {
        viewModels = [PokePreview(name: "Bulbasaur", url: ""),
                      PokePreview(name: "Ivysaur", url: "")].map(PokeListCellViewModel.init)
        onUpdate()
    }
}
