//
//  LoadJSON.swift
//  Sanctuary
//
//  Created by Valados on 02.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation
import RealmSwift

class LoadJSON{
    
    static func parse<T:Decodable>(jsonData: Data,type:T.Type)->Decodable {
        do {
            let decodedData = try JSONDecoder().decode(type,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return 1
    }
    static func readFromJSON(name:String)->Data?{
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("error")
        }
        return nil
    }
}
