//
//  Health.swift
//  Sanctuary
//
//  Created by Valados on 13.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - HealthElement
struct HealthElement: Codable {
    let health: String
}

typealias Health = [HealthElement]
