//
//  Game.swift
//  Sanctuary
//
//  Created by Valados on 01.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation
import RealmSwift

struct Game{
    
    var playerList = [Player]()
    let players:Int
    
    init(numberOfPlayers: Int) {
        self.players = numberOfPlayers
        guard players > 0 else {
            return
        }
        RandomGeneration()
        for index in 0..<numberOfPlayers{
            let player = createPlayer(withNumber: index)
            playerList.append(player)
        }
    }
    init(players:[Player]) {
        self.playerList = players
        self.players = players.count
    }
    
  
    let objectKey: [String:Object.Type] = ["health":HealthRealm.self, "fear":FearsRealm.self,"additionalInformation":AddInfoRealm.self,"hobby":HobbiesRealm.self,"job":JobsRealm.self,"characteristic":TreatsOfCharacterRealm.self,"baggage":BaggageRealm.self,"specialCard":SpecialCardsRealm.self]
    
    let sex:[String] = ["Мужской","Женский"]
    let orientation:[String] = ["Гомосексуальность","Гетеросексуальность","Бисексуальность"]
    var ageArray:[Int] = []
    var sexArray:[String] = []
    var orientationArray:[String] = []
     
    var characterArray:[Int] = []
    var baggageArray:[Int] = []
    var fearArray:[Int] = []
    var hobbyArray:[Int] = []
    var jobArray:[Int] = []
    var jobExperienceArray:[Int] = []
    var specialArray:[Int] = []
    var addInfo:[Int] = []
    var healthArray:[Int] = []
    var fileURLShare:[URL] = []
    
    mutating func RandomGeneration(){
        characterArray =  createPersonInformation(array: RealmData.character, multiplier: 1)
        baggageArray =  createPersonInformation(array: RealmData.baggage, multiplier: 1)
        fearArray =  createPersonInformation(array: RealmData.fear, multiplier: 1)
        hobbyArray =  createPersonInformation(array: RealmData.hobby, multiplier: 1)
        jobArray =  createPersonInformation(array: RealmData.job, multiplier:1)
        specialArray =  createPersonInformation(array: RealmData.specialCondition, multiplier: 2)
        addInfo =  createPersonInformation(array: RealmData.addInformation, multiplier: 1)
        healthArray = createPersonInformation(array: RealmData.health, multiplier: 1)
        for i in 0..<players{
            ageArray.append(Int.random(in: 18...70))
            sexArray.append(sex[Int.random(in: 0...sex.count-1)])
            orientationArray.append(orientation[Int.random(in: 0...orientation.count-1)])
            jobExperienceArray.append(Int.random(in:0...ageArray[i]-18))
        }
    }
    func createPersonInformation<T:Object>(array:Results<T>,multiplier:Int)->[Int]{
        var playerArray:[Int] = []
        for _ in 1...(multiplier*players) {
            var rand = Int.random(in: 0..<array.count)
            if playerArray.isEmpty == false{
                if playerArray.contains(rand) {
                    repeat{
                        rand = Int.random(in: 0..<array.count)
                    }
                    while playerArray.contains(rand)
                    playerArray.append(rand)
                }
                else{
                    playerArray.append(rand)
                }
            }
            else{
                playerArray.append(rand)
            }
        }
        return playerArray
    }
    
    func createPlayer(withNumber value:Int)->Player{
        var player = Player()
        player.additionalInformation = RealmData.generateCharacterstic(objectType: AddInfoRealm.self, key:"additionalInformation", index: addInfo[value])
        player.baggage = RealmData.generateCharacterstic(objectType: BaggageRealm.self, key: "baggage", index: baggageArray[value])
        player.treatOfCharacter = RealmData.generateCharacterstic(objectType: TreatsOfCharacterRealm.self, key: "characteristic", index: characterArray[value])
        player.fear = RealmData.generateCharacterstic(objectType: FearsRealm.self, key: "fear", index: fearArray[value])
        player.health = RealmData.generateCharacterstic(objectType: HealthRealm.self, key: "health", index: healthArray[value])
        player.hobby = RealmData.generateCharacterstic(objectType: HobbiesRealm.self, key: "hobby", index: hobbyArray[value])
        player.job = RealmData.generateCharacterstic(objectType: JobsRealm.self, key: "job", index: jobArray[value])
        player.firstSpecialCard = RealmData.generateCharacterstic(objectType: SpecialCardsRealm.self, key: "specialCard", index: specialArray[value])
        player.secondSpecialCard = RealmData.generateCharacterstic(objectType: SpecialCardsRealm.self, key: "specialCard", index: specialArray[value+players])
        player.age = ageArray[value]
        player.jobExperience = jobExperienceArray[value]
        player.orientation = orientationArray[value]
        player.sex = sexArray[value]
        dump(player)
        return player
    }
    
}

