import Foundation

struct NetworkContext: NetworkContextProtocol {
    let configuration: NetworkConfigurationProtocol
    
    func getPokemonList(completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        getPokemonList(with: configuration.baseUrl + "/api/v2/pokemon",
                       completion: completion)
    }
    
    func getPokemonList(with urlString: String, completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        return get(url,
                   session: URLSession.shared,
                   dispatcher: MainQueueDispatcher(),
                   completion: completion)
    }
    
    func getPokemonImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> Request? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        return get(url,
                   session: URLSession.shared,
                   dispatcher: MainQueueDispatcher(),
                   completion: completion)
    }
}

private extension NetworkContext {
    func get<T: Decodable>(_ url: URL, session: URLSession, dispatcher: Dispatcher, completion: @escaping (Result<T, Error>) -> Void) -> Request {
        let task = session
            .dataTask(with: url,
                      completionHandler: { data, _, error in
                        if let error = error {
                            dispatcher.dispatch { completion(.failure(error)) }
                            return
                        }
                        guard let data = data else {
                            dispatcher.dispatch { completion(.failure(NetworkError.invalidResponse)) }
                            return
                        }
                        
                        do {
                            let list = try JSONDecoder().decode(T.self, from: data)
                            dispatcher.dispatch { completion(.success(list)) }
                        } catch {
                            dispatcher.dispatch { completion(.failure(error)) }
                        }
                      })
        return Request(task: task)
    }
    
    func get(_ url: URL, session: URLSession, dispatcher: Dispatcher, completion: @escaping (Result<Data, Error>) -> Void) -> Request {
        let task = session
            .dataTask(with: url,
                      completionHandler: { data, _, error in
                        if let error = error {
                            dispatcher.dispatch { completion(.failure(error)) }
                            return
                        }
                        guard let data = data else {
                            dispatcher.dispatch { completion(.failure(NetworkError.invalidResponse)) }
                            return
                        }
                        dispatcher.dispatch { completion(.success(data)) }
                      })
        return Request(task: task)
    }
}
