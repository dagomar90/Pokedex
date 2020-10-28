import Foundation

protocol NetworkContextProtocol {
    func getPokemonList(with urlString: String, completion:  @escaping (Result<PokePreviewList, Error>) -> Void)
    func getPokemonImage(with urlString: String, completion:  @escaping (Result<Data, Error>) -> Void)
}
