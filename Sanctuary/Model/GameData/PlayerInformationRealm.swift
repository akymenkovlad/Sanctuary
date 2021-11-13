//
//  GameData.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerInformationRealm: Object {
    @Persisted var additionalInformation:String
    @Persisted var baggage:String
    @Persisted var treatOfCharacter:String
    @Persisted var fear:String
    @Persisted var health:String
    @Persisted var hobby:String
    
    @Persisted var job:String
    @Persisted var jobExperience:Int
    @Persisted var firstSpecialCard: String
    @Persisted var secondSpecialCard: String
    
    @Persisted var age:Int
    @Persisted var sex:String
    @Persisted var orientation: String
}
