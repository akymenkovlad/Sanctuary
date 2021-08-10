//
//  Character.swift
//  Sanctuary
//
//  Created by Valados on 02.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - CharacterElement
struct CharacterElement: Codable {
    let character: String
}
typealias Character = [CharacterElement]
