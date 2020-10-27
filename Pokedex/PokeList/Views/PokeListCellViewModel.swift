import Foundation

struct PokeListCellViewModel {
    let preview: PokePreview
    
    var name: String {
        preview.name
    }
    
    var url: String {
        preview.url
    }
}
