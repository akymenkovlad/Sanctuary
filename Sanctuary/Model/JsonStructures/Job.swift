//
//  Job.swift
//  Sanctuary
//
//  Created by Valados on 05.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

// MARK: - JobElement
struct JobElement: Codable {
    let job: String
}

typealias Job = [JobElement]
