//
//  PlayerInformation.swift
//  Sanctuary
//
//  Created by Valados on 27.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

class Player{
    var additionalInformation:String
    var baggage:String
    var treatOfCharacter:String
    var fear:String
    var health:String
    var hobby:String
    
    var job:String
    var jobExperience:Int
    var firstSpecialCard: String
    var secondSpecialCard: String
    
    var age:Int
    var sex:String
    var orientation: String
    
    init() {
        self.additionalInformation = "additionalInformation"
        self.baggage = "baggage"
        self.treatOfCharacter = "character"
        self.fear = "fear"
        self.health = "health"
        self.hobby = "hobby"
        self.job = "job"
        self.sex = "sex"
        self.firstSpecialCard = "firstSpecialCard"
        self.secondSpecialCard = "secondSpecialCard"
        self.age = 0
        self.jobExperience = 0
        self.orientation = "orientation"
    }
    init(addInfo additionalInformation:String,
         baggage:String,
         character:String,
         fear:String,
         health:String,
         hobby:String,
         job:String,
         sex:String,
         card1 firstSpecialCard:String,
         card2 secondSpecialCard:String,
         gender:String,
         age:Int,
         jobExperience:Int){
        
        self.additionalInformation = additionalInformation
        self.baggage = baggage
        self.treatOfCharacter = character
        self.fear = fear
        self.health = health
        self.hobby = hobby
        self.job = job
        self.sex = sex
        self.firstSpecialCard = firstSpecialCard
        self.secondSpecialCard = secondSpecialCard
        self.age = age
        self.jobExperience = jobExperience
        self.orientation = gender
    }

}
