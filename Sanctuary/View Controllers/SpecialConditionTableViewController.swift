//
//  SpecialConditionTableViewController.swift
//  Sanctuary
//
//  Created by Valados on 27.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import UIKit

class SpecialConditionTableViewController: UITableViewController {

    var fear = Fear()
    var health = Health()
    var hobby = Hobby()
    var names = ["Fear","Health","Hobby"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        for i in 0...2 {
            parseAllJSON(fileName: names[i])
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            newDataAlert(title: "Новая фобия", message: "\(fear[Int.random(in: 0...fear.count-1)].fear)")
            break
        case 1:
            newDataAlert(title: "Новое здоровье", message: "\(health[Int.random(in: 0...health.count-1)].health)")
            break
        case 2:
            newDataAlert(title: "Новое хобби", message: "\(hobby[Int.random(in: 0...hobby.count-1)].hobby)")
            break
        default:
            break
        }
    }
    func newDataAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    func parseAllJSON(fileName:String){
           if let localData = LoadJSON.readFromJSON(name: fileName) {
               switch fileName {
               case "Health":
                   health = LoadJSON.parse(jsonData: localData, type: Health.self) as! Health
                   break
               case "Fear":
                   fear = LoadJSON.parse(jsonData: localData, type: Fear.self) as! Fear
                   break
               case "Hobby":
                   hobby = LoadJSON.parse(jsonData: localData, type: Hobby.self) as! Hobby
                   break
               default:
                   break
               }
           }
       }
}
