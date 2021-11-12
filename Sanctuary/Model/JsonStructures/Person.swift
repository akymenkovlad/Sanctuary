//
//  Person.swift
//  Sanctuary
//
//  Created by Valados on 01.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let person = try? newJSONDecoder().decode(Person.self, from: jsonData)

// MARK: - PersonElement
struct PersonElement: Codable {
    let age: Int
    let gender, orientation: String
}
typealias Person = [PersonElement]
