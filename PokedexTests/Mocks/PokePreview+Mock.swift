import Foundation
@testable import Pokedex

extension PokePreview {
    static var mock: PokePreview { PokePreview(name: "MockName", url: "MockUrl") }
    static var wrongUrl: PokePreview { PokePreview(name: "MockName", url: "") }
}
