//
//  PlayersTableViewController.swift
//  Sanctuary
//
//  Created by Valados on 10.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

   var catastrophy:Int = 0
   
   var ageArray:[Int] = []
   var genderArray:[String] = []
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
    
   let gender:[String] = ["Мужской","Женский"]
   let orientation:[String] = ["Гомосексуальность","Гетеросексуальность","Бисексуальность"]
    
   let newGame = NewGame.player
   var players = [PlayerInformation]()
   
    
   var character = Character()
   var addInformation = AddInformation()
   var baggage = Baggage()
   var disaster = Disaster()
   var fear = Fear()
   var hobby = Hobby()
   var job = Job()
   var specialCondition = Condition()
   var health = Health()
   
   var arrayJSON = ["Person","Additional Info", "Baggage","Character","Disaster","Fear","Hobby","Job","Special Cards","Health"]
    

    @IBOutlet weak var sendDataButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(alpha: 1.0)
        for i in 0...self.arrayJSON.count-1 {
            self.parseAllJSON(fileName: self.arrayJSON[i])
        }
        self.GenerateNewGame()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.removeSpinner()
            self.view.isUserInteractionEnabled = true
        }
    }
    @IBAction func GenerateNewGame(_ sender: Any) {
        let vc =  UIActivityViewController(activityItems: fileURLShare, applicationActivities: [])
        present(vc, animated: true)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        let i = indexPath.row
        let segueText = """
        \(disaster[catastrophy].disaster)
        
        Профессия: \(job[jobArray[i]].job) стаж - \(jobExperienceArray[i]) лет
        
        Возраст:\(ageArray[i]) лет,
        пол-\(genderArray[i]),
        ориентация - \(orientationArray[i])
        
        Здоровье:\(health[healthArray[i]].health)
        
        Хобби:\(hobby[hobbyArray[i]].hobby)
        
        Дополнительная информация:\(addInformation[addInfo[i]].additionalInfo)
        
        Фобия:\(fear[fearArray[i]].fear)
        
        Багаж:\(baggage[baggageArray[i]].baggage)
        
        Черта:\(character[characterArray[i]].character)
        
        Специальные условия:
        
        1.\(specialCondition[specialArray[i]].specialCondition)
        
        2.\(specialCondition[specialArray[2*newGame.players-1-i]].specialCondition)
        """
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PlayerInfoViewController") as? PlayerInfoViewController else {return}
        vc.userInfo = segueText
        show(vc, sender: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newGame.players
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Игроки"
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .label
            headerView.textLabel?.font = .italicSystemFont(ofSize: 15)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)

        cell.textLabel?.text = "Игрок \(indexPath.row+1)"
        cell.textLabel?.textColor = .label
        cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        return cell
    }
    //MARK: - JSON
    func parseAllJSON(fileName:String){
        if let localData = LoadJSON.readFromJSON(name: fileName) {
            switch fileName {
            case "Health":
                health = LoadJSON.parse(jsonData: localData, type: Health.self) as! Health
                break
            case "Additional Info":
                addInformation = LoadJSON.parse(jsonData: localData, type: AddInformation.self) as! AddInformation
                break
            case "Baggage":
                baggage = LoadJSON.parse(jsonData: localData, type: Baggage.self) as! Baggage
                break
            case "Character":
                character = LoadJSON.parse(jsonData: localData, type: Character.self) as! Character
                break
            case "Disaster":
                disaster = LoadJSON.parse(jsonData: localData, type: Disaster.self) as! Disaster
                break
            case "Fear":
                fear = LoadJSON.parse(jsonData: localData, type: Fear.self) as! Fear
                break
            case "Hobby":
                hobby = LoadJSON.parse(jsonData: localData, type: Hobby.self) as! Hobby
                break
            case "Job":
                job = LoadJSON.parse(jsonData: localData, type: Job.self) as! Job
                break
            case "Special Cards":
                specialCondition = LoadJSON.parse(jsonData: localData, type: Condition.self) as! Condition
                break
            default:
                break
            }
        }
    }
    func createPersonInformation<T:Decodable>(array:[T],multiplier:Int)->[Int]{
        var playerArray:[Int] = []
        for _ in 1...multiplier*newGame.players {
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
    func RandomGeneration(){
        catastrophy = Int.random(in: 0..<disaster.count)
        characterArray =  createPersonInformation(array: character, multiplier: 1)
        baggageArray =  createPersonInformation(array: baggage, multiplier: 1)
        fearArray =  createPersonInformation(array: fear, multiplier: 1)
        hobbyArray =  createPersonInformation(array: hobby, multiplier: 1)
        jobArray =  createPersonInformation(array: job, multiplier: 1)
        specialArray =  createPersonInformation(array: specialCondition, multiplier: 2)
        addInfo =  createPersonInformation(array: addInformation, multiplier: 1)
        healthArray = createPersonInformation(array: health, multiplier: 1)
        for i in 0...newGame.players-1{
            ageArray.append(Int.random(in: 18...70))
            genderArray.append(gender[Int.random(in: 0...gender.count-1)])
            orientationArray.append(orientation[Int.random(in: 0...orientation.count-1)])
            jobExperienceArray.append(Int.random(in:0...ageArray[i]-18))
        }
    }
    func GenerateNewGame() {
        RandomGeneration()
        for i in 0...newGame.players-1 {
            let text = """
            \(disaster[catastrophy].disaster)
            
            Профессия: \(job[jobArray[i]].job) стаж - \(jobExperienceArray[i]) лет
            
            Возраст:\(ageArray[i]) лет,
            пол-\(genderArray[i]),
            ориентация - \(orientationArray[i])
            
            Здоровье:\(health[healthArray[i]].health)
            
            Хобби:\(hobby[hobbyArray[i]].hobby)
            
            Дополнительная информация:\(addInformation[addInfo[i]].additionalInfo)
            
            Фобия:\(fear[fearArray[i]].fear)
            
            Багаж:\(baggage[baggageArray[i]].baggage)
            
            Черта:\(character[characterArray[i]].character)
            
            Специальные условия:
            
            1.\(specialCondition[specialArray[i]].specialCondition)
            
            2.\(specialCondition[specialArray[2*newGame.players-1-i]].specialCondition)
            """
            let file = "Игрок \(i+1).txt"
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                 let fileURL = dir.appendingPathComponent(file)
                //writing
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {/* error handling here */}
                fileURLShare.append(fileURL)
            }
        }
    }
}
