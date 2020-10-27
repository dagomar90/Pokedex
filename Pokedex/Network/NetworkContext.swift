import Foundation

struct NetworkContext: NetworkContextProtocol {
    let configuration: NetworkConfigurationProtocol = NetworkConfiguration(baseUrl: "https://pokeapi.co")
    
    func getPokemonList(completion: (Result<[PokePreview], Error>) -> Void) {
        
    }
}
