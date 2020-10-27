import Foundation

protocol NetworkContextProtocol {
    func getPokemonList(with urlString: String, completion:  @escaping (Result<PokePreviewList, Error>) -> Void)
}
