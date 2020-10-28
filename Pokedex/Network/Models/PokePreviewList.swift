import Foundation

struct PokePreviewList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokePreview]
}
