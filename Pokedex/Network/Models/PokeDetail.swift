import Foundation

struct PokeDetail: Codable {
    let id: Int
    let name: String
    let base_experience: Int
    let height: Int
    let is_default: Bool
    let order: Int
    let weight: Int
    let location_area_encounters: String
    let sprites: PokeImages
    let abilities: [PokeAbility]
    let stats: [PokeStat]
    let species: PokeResource
    let forms: [PokeResource]
}
