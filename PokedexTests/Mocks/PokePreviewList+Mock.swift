import Foundation
@testable import Pokedex

extension PokePreviewList {
    static var mock: PokePreviewList { PokePreviewList(count: 2,
                                                       next: nil,
                                                       previous: nil,
                                                       results: [PokePreview.mock, PokePreview.wrongUrl]) }
    static var withNext: PokePreviewList { PokePreviewList(count: 2,
                                                       next: "https://pokeapi.com",
                                                       previous: nil,
                                                       results: [PokePreview.mock, PokePreview.wrongUrl]) }
}

extension PokePreviewList {
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
