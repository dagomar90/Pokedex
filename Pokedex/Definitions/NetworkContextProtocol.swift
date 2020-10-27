import Foundation

protocol NetworkContextProtocol {
    func getPokemonList(completion: (Result<[PokePreview], Error>) -> Void)
}
