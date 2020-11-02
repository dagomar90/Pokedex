import XCTest
@testable import Pokedex

class NetworkContextTests: XCTestCase {
    var sut: NetworkContext!
    var urlSession: URLSessionMock!
    var dispatcher: DispatcherMock!
    var imagesCache: ImagesCacheMock!
    
    override func setUpWithError() throws {
        urlSession = URLSessionMock()
        dispatcher = DispatcherMock()
        imagesCache = ImagesCacheMock()
        dispatcher.dispatchHandler = { $0() }
        sut = NetworkContext(configuration: NetworkConfiguration.mock,
                             urlSession: urlSession,
                             dispatcher: dispatcher,
                             imagesCache: imagesCache)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 0)
        XCTAssertEqual(dispatcher.dispatchCount, 0)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
    }
    
    func testGetPokemonList_failure_notFound() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, URLResponse.notFound, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonList(with: "http://valid",
                               completion: { result in
                                guard case let .failure(error) = result else {
                                    XCTFail("error must be returned in failure case")
                                    return
                                }
                                XCTAssertEqual(error as! NetworkError, NetworkError.notFound)
                               })
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 0)
        XCTAssertEqual(dispatcher.dispatchCount, 0)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
    }
    
    func testGetPokemonDetail_failure_notFound() {
        urlSession.dataTaskWithUrlCompletionHandlerHandler = { _, completion in
            completion(nil, URLResponse.notFound, nil)
            return UrlSessionDataTaskMock()
        }
        
        _ = sut.getPokemonDetail(with: "http://valid",
                                 completion: { result in
                                    guard case let .failure(error) = result else {
                                        XCTFail("error must be returned in failure case")
                                        return
                                    }
                                    XCTAssertEqual(error as! NetworkError, NetworkError.notFound)
                                 })
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 1)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 2)
        XCTAssertEqual(imagesCache.removeUUIDCount, 1)
        XCTAssertEqual(imagesCache.storeImageWithUrlDataCount, 1)
    }
    
    func testGetPokemonImage_success_fromCache() {
        imagesCache.getImageWithUrlHandler = { _ in
            return Data()
        }
        
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 0)
        XCTAssertEqual(dispatcher.dispatchCount, 0)
        XCTAssertEqual(imagesCache.removeUUIDCount, 0)
        XCTAssertEqual(imagesCache.storeImageWithUrlDataCount, 0)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 0)
        XCTAssertEqual(dispatcher.dispatchCount, 0)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 2)
        XCTAssertEqual(imagesCache.removeUUIDCount, 1)
        XCTAssertEqual(imagesCache.storeImageWithUrlDataCount, 0)
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
        XCTAssertEqual(urlSession.dataTaskWithUrlCompletionHandlerCount, 1)
        XCTAssertEqual(dispatcher.dispatchCount, 2)
        XCTAssertEqual(imagesCache.removeUUIDCount, 1)
        XCTAssertEqual(imagesCache.storeImageWithUrlDataCount, 0)
    }
}
