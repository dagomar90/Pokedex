import Foundation

struct PokeInfoViewModel {
    let title: String
    let keyValues: [PokeKeyValue]
    
    var pokeInfoRowViewModels: [PokeInfoRowViewModel] {
        keyValues.map({ PokeInfoRowViewModel(key: $0.key, value: $0.value) })
    }
}
