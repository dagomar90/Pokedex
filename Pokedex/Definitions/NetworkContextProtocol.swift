import Foundation

protocol NetworkContextProtocol {
    func getPokemonList(completion:  @escaping (Result<PokePreviewList, Error>) -> Void)
}
