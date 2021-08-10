//
//  Hobby.swift
//  Sanctuary
//
//  Created by Valados on 05.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - HobbyElement
struct HobbyElement: Codable {
    let hobby: String
}

typealias Hobby = [HobbyElement]
