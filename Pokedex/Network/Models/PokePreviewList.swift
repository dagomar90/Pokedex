//
//  PokePreviewList.swift
//  Pokedex
//
//  Created by Giovanni Catania on 27/10/2020.
//

import Foundation

struct PokePreviewList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokePreview]
}
