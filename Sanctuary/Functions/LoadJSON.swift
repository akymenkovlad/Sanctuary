//
//  LoadJSON.swift
//  Sanctuary
//
//  Created by Valados on 02.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import Foundation

class LoadJSON{
  /*  static func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        let urlB = URL(string: "https://m.sumy.kiev.ua")!
        var request = URLRequest(url: urlB)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = urlString.data(using: .utf8)
            let urlSession = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
    }*/
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
                print(error)
            }
         return nil
     }
}
