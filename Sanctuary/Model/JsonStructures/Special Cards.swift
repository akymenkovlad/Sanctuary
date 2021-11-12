//
//  Special Cards.swift
//  Sanctuary
//
//  Created by Valados on 05.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - ConditionElement
struct ConditionElement: Codable {
    let specialCondition: String
}

typealias Condition = [ConditionElement]
