//
//  GameViewController.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import UIKit

protocol isAbleToReceiveData {
    func pass(numberOfPlayers: Int)
}
class GameViewController: UIViewController {
    
    var arrayJSON = ["Person","Additional Info", "Baggage","Character","Disaster","Fear","Hobby","Job","Special Cards","Health"]
    private var numberOfPlayers = 0
    private var players = [Player]()
    private var game: Game {
        get{
            Game(numberOfPlayers: numberOfPlayers)
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...self.arrayJSON.count-1 {
            RealmData.parseAllJSONAndWriteToRealm(fileName: self.arrayJSON[i])
        }
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(newGameButtonPressed))
        activateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateNewGame()
       // print(game)
    }
    
    @objc func newGameButtonPressed(){
        UserDefaults.standard.setValue(false, forKey: "GameIsCreated")
        let vc = StartingPageViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func validateNewGame(){
        if let gameState = UserDefaults.standard.value(forKey: "GameIsCreated") as? Bool, !gameState{
            let vc = StartingPageViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
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
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
    
}
extension GameViewController: isAbleToReceiveData{
    func pass(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        print("Players count:\(self.numberOfPlayers)")
        
    }
}
