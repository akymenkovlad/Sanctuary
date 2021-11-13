//
//  GameViewController.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import UIKit
import RealmSwift

protocol isAbleToReceiveData: AnyObject{
    func startNewGameWith(numberOfPlayers: Int)
    func getPlayerInfo(player:Player,number:Int)
}
class GameViewController: UIViewController {
    
    let realm = try! Realm()
    var arrayJSON = ["Person","Additional Info", "Baggage","Character","Disaster","Fear","Hobby","Job","Special Cards","Health"]
    private var numberOfPlayers = 0
    private var game = Game(numberOfPlayers: 0)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(newGameButtonPressed))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                              style: .done,
                                                              target: self,
                                                              action: #selector(newGameButtonPressed)),
                                          UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                                              style: .done,
                                                              target: self,
                                                              action: #selector(newGameButtonPressed))]
        activateConstraints()
        checkInformationAboutGameAndPlayers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateNewGame()
        tableView.reloadData()
    }
    
    @objc func newGameButtonPressed(){
        UserDefaults.standard.setValue(false, forKey: "GameIsCreated")
        presentNewGameScreen()
    }
    
    private func validateNewGame(){
        if UserDefaults.standard.object(forKey: "GameIsCreated") == nil
        {
            UserDefaults.standard.set(false, forKey: "GameIsCreated")
        }
        if let gameState = UserDefaults.standard.value(forKey: "GameIsCreated") as? Bool, !gameState{
            presentNewGameScreen()
        }
    }
    private func presentNewGameScreen(){
        guard !RealmData.players.isEmpty else {
            return
        }
        try! realm.write {
            realm.delete(RealmData.players)
        }
        let vc = StartingPageViewController()
        vc.title = "Sanctuary"
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func saveDataAboutPlayers(){
        try! realm.write {
            for playerElement in game.playerList {
                // Add player to database.
                let player = PlayerInformationRealm()
                player.additionalInformation = playerElement.additionalInformation
                player.baggage = playerElement.baggage
                player.treatOfCharacter = playerElement.treatOfCharacter
                player.fear = playerElement.fear
                player.health = playerElement.health
                player.hobby = playerElement.hobby
                player.job = playerElement.job
                player.jobExperience = playerElement.jobExperience
                player.firstSpecialCard = playerElement.firstSpecialCard
                player.secondSpecialCard = playerElement.secondSpecialCard
                player.age = playerElement.age
                player.sex = playerElement.sex
                player.orientation = playerElement.orientation
                realm.add(player)
            }
        }
    }
    
    private func checkInformationAboutGameAndPlayers(){
        let realm = try! Realm()
        guard !RealmData.health.isEmpty,
              !RealmData.job.isEmpty,
              !RealmData.fear.isEmpty,
              !RealmData.baggage.isEmpty,
              !RealmData.hobby.isEmpty,
              !RealmData.addInformation.isEmpty,
              !RealmData.specialCondition.isEmpty,
              !RealmData.character.isEmpty else {
                  print("Empty data")
                  for i in 0...self.arrayJSON.count-1 {
                      RealmData.parseAllJSONAndWriteToRealm(fileName: self.arrayJSON[i])
                  }
                  return
              }
        guard !RealmData.players.isEmpty else{
            return
        }
        let players = realm.objects(PlayerInformationRealm.self)
        var playerArray = [Player]()
        for player in players {
            let obj = Player(addInfo:player.additionalInformation ,
                             baggage:player.baggage ,
                             character:player.treatOfCharacter,
                             fear: player.fear,
                             health: player.health,
                             hobby:player.hobby ,
                             job: player.job,
                             sex: player.sex,
                             card1:player.firstSpecialCard,
                             card2:player.secondSpecialCard,
                             orientation:player.orientation,
                             age: player.age,
                             jobExperience:player.jobExperience )
            playerArray.append(obj)
        }
        game = Game(players: playerArray)
        numberOfPlayers = game.players
        dump(game)
        tableView.reloadData()
    }
    
    private func activateConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
extension GameViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Игрок \(indexPath.row+1)"
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.tintColor = UIColor.darkRed
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Игроки"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayerDetailsViewController(player:game.playerList[indexPath.row], number: indexPath.row)
        vc.title = "Игрок \(indexPath.row+1)"
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension GameViewController: isAbleToReceiveData{
    func startNewGameWith(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        print("Players count:\(self.numberOfPlayers)")
        game = Game(numberOfPlayers: self.numberOfPlayers)
        saveDataAboutPlayers()
    }
    func getPlayerInfo(player: Player, number: Int) {
        game.playerList[number] = player
    }
}
