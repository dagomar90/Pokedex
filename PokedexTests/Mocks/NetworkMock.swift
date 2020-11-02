import Foundation
@testable import Pokedex

class NetworkMock: NetworkContextProtocol {
    var getConfigurationCount: Int = 0
    var getConfigurationHandler: () -> NetworkConfigurationProtocol = { NetworkConfiguration.mock }
    var getPokemonListCount: Int = 0
    var getPokemonListHandler: ((Result<PokePreviewList, Error>) -> Void) -> Request? = { _ in nil }
    var getPokemonListWithUrlStringCount: Int = 0
    var getPokemonListWithUrlHandler: (String, (Result<PokePreviewList, Error>) -> Void) -> Request? = { _, _ in nil }
    var getPokemonImageCount: Int = 0
    var getPokemonImageHandler: (String, (Result<Data, Error>) -> Void) -> Request? = { _, _ in nil }
    var getPokemonDetailCount: Int = 0
    var getPokemonDetailHandler: (String, (Result<PokeDetail, Error>) -> Void) -> Request? = { _, _ in nil }
    
    var configuration: NetworkConfigurationProtocol {
        getConfigurationCount += 1
        return getConfigurationHandler()
    }
    
    func getPokemonList(completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        getPokemonListCount += 1
        return getPokemonListHandler(completion)
    }
    
    func getPokemonList(with urlString: String, completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        getPokemonListWithUrlStringCount += 1
        return getPokemonListWithUrlHandler(urlString, completion)
    }
    
    func getPokemonImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> Request? {
        getPokemonImageCount += 1
        return getPokemonImageHandler(urlString, completion)
    }
    
    func getPokemonDetail(with urlString: String, completion: @escaping (Result<PokeDetail, Error>) -> Void) -> Request? {
        getPokemonDetailCount += 1
        return getPokemonDetailHandler(urlString, completion)
    }
}
