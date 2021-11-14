//
//  PlayerManager.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import Foundation
import RealmSwift

class RealmData{
    
    // static let realm = try! Realm()
    
    static var character:Results<TreatsOfCharacterRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(TreatsOfCharacterRealm.self)
        }
    }
    static var addInformation:Results<AddInfoRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(AddInfoRealm.self)
        }
    }
    static var baggage:Results<BaggageRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(BaggageRealm.self)
        }
    }
    static var fear:Results<FearsRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(FearsRealm.self)
        }
    }
    static var hobby:Results<HobbiesRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(HobbiesRealm.self)
        }
    }
    static var job:Results<JobsRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(JobsRealm.self)
        }
    }
    static var specialCondition:Results<SpecialCardsRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(SpecialCardsRealm.self)
        }
    }
    static var health:Results<HealthRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(HealthRealm.self)
        }
    }
    static var players:Results<PlayerInformationRealm> {
        get {
            let realm = try! Realm()
            return realm.objects(PlayerInformationRealm.self)
        }
    }
    
    static func generateCharacterstic(objectType type: Object.Type, key: String, index:Int?)->String{
        let realm = try! Realm()
        let objects = realm.objects(type.self)
        var value = ""
        if let index = index {
            value = objects[index].value(forKey: key) as! String
        }
        else{
            value = objects[Int.random(in: 0..<objects.count)].value(forKey: key) as! String
        }
        return value
    }
    //MARK: - JSON
    static func parseAllJSONAndWriteToRealm(fileName:String){
        if let localData = LoadJSON.readFromJSON(name: fileName) {
            let realm = try! Realm()
            switch fileName {
            case "Health":
                let data = LoadJSON.parse(jsonData: localData, type: Health.self) as! Health
                try! realm.write {
                    for element in data {
                        
                        let obj = HealthRealm()
                        obj.health = element.health
                        realm.add(obj)
                    }
                }
                break
            case "Additional Info":
                let data = LoadJSON.parse(jsonData: localData, type: AddInformation.self) as! AddInformation
                try! realm.write {
                    for element in data {
                        let obj = AddInfoRealm()
                        obj.additionalInformation = element.additionalInfo
                        realm.add(obj)
                    }
                }
                break
            case "Baggage":
                let data = LoadJSON.parse(jsonData: localData, type: Baggage.self) as! Baggage
                try! realm.write {
                    for element in data {
                        let obj = BaggageRealm()
                        obj.baggage = element.baggage
                        realm.add(obj)
                    }
                }
                break
            case "Character":
                let data = LoadJSON.parse(jsonData: localData, type: Character.self) as! Character
                try! realm.write {
                    for element in data {
                        let obj = TreatsOfCharacterRealm()
                        obj.characteristic = element.character
                        realm.add(obj)
                    }
                }
                break
            case "Fear":
                let data = LoadJSON.parse(jsonData: localData, type: Fear.self) as! Fear
                try! realm.write {
                    for element in data {
                        let obj = FearsRealm()
                        obj.fear = element.fear
                        realm.add(obj)
                    }
                }
                break
            case "Hobby":
                let data = LoadJSON.parse(jsonData: localData, type: Hobby.self) as! Hobby
                try! realm.write {
                    for element in data {
                        let obj = HobbiesRealm()
                        obj.hobby = element.hobby
                        realm.add(obj)
                    }
                }
                break
            case "Job":
                let data = LoadJSON.parse(jsonData: localData, type: Job.self) as! Job
                try! realm.write {
                    for element in data {
                        let obj = JobsRealm()
                        obj.job = element.job
                        realm.add(obj)
                    }
                }
                break
            case "Special Cards":
                let data = LoadJSON.parse(jsonData: localData, type: Condition.self) as! Condition
                try! realm.write {
                    for element in data {
                        let obj = SpecialCardsRealm()
                        obj.specialCard = element.specialCondition
                        realm.add(obj)
                    }
                }
                break
            default:
                break
            }
        }
    }
}
