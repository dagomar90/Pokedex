import Foundation
@testable import Pokedex

extension NetworkConfiguration {
    static var mock: NetworkConfiguration { NetworkConfiguration(baseUrl: "http://test_url") }
}
