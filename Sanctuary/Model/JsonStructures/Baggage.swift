//
//  Baggage.swift
//  Sanctuary
//
//  Created by Valados on 05.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - BaggageElement
struct BaggageElement: Codable {
    let baggage: String
}

typealias Baggage = [BaggageElement]
