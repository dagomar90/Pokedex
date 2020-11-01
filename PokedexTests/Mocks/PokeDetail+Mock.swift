import Foundation
@testable import Pokedex

extension PokeDetail {
    static var mock: PokeDetail {
        PokeDetail(id: 0,
                   name: "Name",
                   base_experience: 12,
                   height: 34,
                   is_default: true,
                   order: 3,
                   weight: 220,
                   location_area_encounters: "location",
                   sprites: PokeImages.mock,
                   abilities: [PokeAbility.mock, PokeAbility.mock],
                   stats: [PokeStat.mock],
                   types: [PokeType.mock])
    }
}

extension PokeImages {
    static var mock: PokeImages {
        PokeImages(front_default: "http://front_default",
                   front_shiny: "http://front_shiny",
                   front_female: "http://front_female",
                   front_shiny_female: "http://front_shiny_female",
                   back_default: "http://back_default",
                   back_shiny: "http://back_shiny",
                   back_female: "http://back_female",
                   back_shiny_female: "http://back_shiny_female") }
}

extension PokeAbility {
    static var mock: PokeAbility {
        PokeAbility(is_hidden: false,
                    slot: 1,
                    ability: PokeResource(name: "Ability", url: "http://ability"))
    }
}

extension PokeStat {
    static var mock: PokeStat {
        PokeStat(effort: 0,
                 base_stat: 72,
                 stat: PokeResource(name: "Stat", url: "http://stat"))
    }
}

extension PokeType {
    static var mock: PokeType {
        PokeType(slot: 0,
                 type: PokeResource(name: "Type", url: "http://type"))
    }
}

extension PokeDetail {
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
