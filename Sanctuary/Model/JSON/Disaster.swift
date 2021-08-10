//
//  Disaster.swift
//  Sanctuary
//
//  Created by Valados on 05.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - DisasterElement
struct DisasterElement: Codable {
    let disaster: String
}

typealias Disaster = [DisasterElement]
