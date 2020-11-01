import XCTest
@testable import Pokedex

class NetworkContextTests: XCTestCase {
    var sut: NetworkContext!
    var urlSession: URLSessionMock!
    var dispatcher: DispatcherMock!
    
    override func setUpWithError() throws {
        urlSession = URLSessionMock()
        dispatcher = DispatcherMock()
        dispatcher.dispatchHandler = { $0() }
        sut = NetworkContext(configuration: NetworkConfiguration.mock,
                             urlSession: urlSession,
                             dispatcher: dispatcher)
    }
}

extension NetworkContextTests {
    func testGetPokemonList_success() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokePreviewList.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(completion: { result in
            guard case let .success(list) = result else {
                XCTFail("list must be returned in success case")
                return
            }
            XCTAssertEqual(list, PokePreviewList.mock)
        })
    }
    
    func testGetPokemonList_failure_invalidUrl() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokePreviewList.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(with: "htp:\\invalid",
                               completion: { result in
                                guard case let .failure(error) = result else {
                                    XCTFail("error must be returned in failure case")
                                    return
                                }
                                XCTAssertEqual(error as! NetworkError, NetworkError.invalidUrl)
                               })
    }
    
    func testGetPokemonList_failure_backendError() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, MockError.mock)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(with: "http://valid",
                               completion: { result in
                                guard case let .failure(error) = result else {
                                    XCTFail("error must be returned in failure case")
                                    return
                                }
                                XCTAssertEqual(error as! MockError, MockError.mock)
                               })
    }
    
    func testGetPokemonList_failure_invalidResponse() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(with: "http://valid",
                               completion: { result in
                                guard case let .failure(error) = result else {
                                    XCTFail("error must be returned in failure case")
                                    return
                                }
                                XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
                               })
    }
    
    func testGetPokemonList_failure_decodingError() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokeDetail.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(with: "http://valid",
                               completion: { result in
                                guard case let .failure(error) = result else {
                                    XCTFail("error must be returned in failure case")
                                    return
                                }
                                XCTAssertTrue(error is DecodingError)
                               })
    }
}

extension NetworkContextTests {
    func testGetPokemonDetail_success() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokeDetail.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "http://valid_url",
                                 completion: { result in
                                    guard case let .success(detail) = result else {
                                        XCTFail("list must be returned in success case")
                                        return
                                    }
                                    XCTAssertEqual(detail, PokeDetail.mock)
                                 })
    }
    
    func testGetPokemonDetail_failure_invalidUrl() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokePreviewList.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "htp:\\invalid",
                                 completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! NetworkError, NetworkError.invalidUrl)
                                 })
    }
    
    func testGetPokemonDetail_failure_backendError() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, MockError.mock)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "http://valid",
                                 completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! MockError, MockError.mock)
                                 })
    }
    
    func testGetPokemonDetail_failure_invalidResponse() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "http://valid",
                                 completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
                                 })
    }
    
    func testGetPokemonDetail_failure_decodingError() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokePreviewList.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "http://valid",
                                 completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertTrue(error is DecodingError)
                                 })
    }
}


extension NetworkContextTests {
    func testGetPokemonImage_success() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(Data(), nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonImage(with: "http://valid_url",
                                completion: { result in
                                    guard case let .success(data) = result else {
                                        XCTFail("data must be returned in success case")
                                        return
                                    }
                                    XCTAssertEqual(data, Data())
                                })
    }
    
    func testGetPokemonImage_failure_invalidUrl() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(PokePreviewList.mock.data, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonImage(with: "htp:\\invalid",
                                completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! NetworkError, NetworkError.invalidUrl)
                                })
    }
    
    func testGetPokemonImage_failure_backendError() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, MockError.mock)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonImage(with: "http://valid",
                                completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! MockError, MockError.mock)
                                })
    }
    
    func testGetPokemonImage_failure_invalidResponse() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, nil, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonImage(with: "http://valid",
                                completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
                                })
    }
}
