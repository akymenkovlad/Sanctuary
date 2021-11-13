//
//  GameData.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import Foundation
import RealmSwift

class HealthRealm: Object {
    @Persisted var health: String
}
class FearsRealm: Object {
    @Persisted var fear: String
}
class AddInfoRealm: Object {
    @Persisted var additionalInformation: String
}
class HobbiesRealm: Object {
    @Persisted var hobby: String
}
class JobsRealm: Object {
    @Persisted var job: String
}
class TreatsOfCharacterRealm: Object {
    @Persisted var characteristic: String
}
class BaggageRealm: Object {
    @Persisted var baggage: String
}
class SpecialCardsRealm: Object {
    @Persisted var specialCard: String
}
