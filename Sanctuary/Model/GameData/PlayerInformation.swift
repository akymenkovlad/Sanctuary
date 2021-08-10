//
//  PlayerInformation.swift
//  Sanctuary
//
//  Created by Valados on 27.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

class PlayerInformation{
    var additionalInformation:String
    var baggage:String
    var character:String
    var disaster:String
    var fear:String
    var health:String
    var hobby:String
    var job:String
    var person:String
    init(additionalInformation:String,baggage:String,character:String,disaster:String,fear:String,health:String,hobby:String,job:String,person:String) {
        self.additionalInformation = additionalInformation
        self.baggage = baggage
        self.character = character
        self.disaster = disaster
        self.fear = fear
        self.health = health
        self.hobby = hobby
        self.job = job
        self.person = person
    }
}
