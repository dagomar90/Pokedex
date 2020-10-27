import Foundation

struct PokeListCellViewModel {
    let preview: PokePreview
    var onSelect: (PokePreview) -> Void = { _ in }
    
    var name: String {
        preview.name
    }
    
    var url: String {
        preview.url
    }
    
    func select() {
        onSelect(preview)
    }
}
