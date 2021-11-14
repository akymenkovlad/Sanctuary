//
//  PlayerDetailsViewController.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import UIKit
import RealmSwift
import JGProgressHUD

class PlayerDetailsViewController: UIViewController {
    
    var spinner = JGProgressHUD(style: .dark)
    
    var player: Player
    weak var delegate: isAbleToReceiveData?
    var playerNumber: Int
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    init(player:Player, number:Int) {
        self.player = player
        self.playerNumber = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        activateConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = delegate {
            delegate.getPlayerInfo(player: player, number: playerNumber)
        }
        super.viewWillDisappear(animated)
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
extension PlayerDetailsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else if section == 1 || section == 8{
            return 2
        }
        else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(player.sex)"
            case 1:
                cell.textLabel?.text = "\(player.orientation)"
            case 2:
                cell.textLabel?.text = "Возраст:\(player.age)"
            default:
                cell.textLabel?.text = ""
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(player.job)"
            case 1:
                cell.textLabel?.text = "Опыт работы:\(player.jobExperience)"
            default:
                cell.textLabel?.text = ""
            }
        case 2:
            cell.textLabel?.text = "\(player.health)"
        case 3:
            cell.textLabel?.text = "\(player.additionalInformation)"
        case 4:
            cell.textLabel?.text = "\(player.hobby)"
        case 5:
            cell.textLabel?.text = "\(player.fear)"
        case 6:
            cell.textLabel?.text = "\(player.baggage)"
        case 7:
            cell.textLabel?.text = "\(player.treatOfCharacter)"
        case 8:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(player.firstSpecialCard)"
            case 1:
                cell.textLabel?.text = "\(player.secondSpecialCard)"
            default:
                cell.textLabel?.text = ""
            }
        default:
            cell.textLabel?.text = ""
            break
        }
        cell.accessoryType = .detailButton
        cell.tintColor = UIColor.darkRed
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        var valueString = ""
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                valueString = "\(player.sex)"
            case 1:
                valueString = "\(player.orientation)"
            case 2:
                valueString = "Возраст:\(player.age)"
            default:
                valueString = ""
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                valueString = "\(player.job)"
            case 1:
                valueString = "Опыт работы:\(player.jobExperience)"
            default:
                valueString = ""
            }
        case 2:
            valueString = "\(player.health)"
        case 3:
            valueString = "\(player.additionalInformation)"
        case 4:
            valueString = "\(player.hobby)"
        case 5:
            valueString = "\(player.fear)"
        case 6:
            valueString = "\(player.baggage)"
        case 7:
            valueString = "\(player.treatOfCharacter)"
        case 8:
            switch indexPath.row {
            case 0:
                valueString = "\(player.firstSpecialCard)"
            case 1:
                valueString = "\(player.secondSpecialCard)"
            default:
                valueString = ""
            }
        default:
            valueString = ""
            break
        }
        let alert = UIAlertController(title: valueString, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Поменять значение", style: .default, handler: {_ in
            self.spinner.show(in: tableView)
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    let sex = Bool.random() ? "Мужчина":"Женщина"
                    self.player.sex  = sex
                case 1:
                    switch Int.random(in: 0...2){
                    case 0:
                        self.player.orientation = "Гомосексуальность"
                    case 1:
                        self.player.orientation = "Гетеросексуальность"
                    case 2:
                        self.player.orientation = "Бисексуальность"
                    default:
                        break
                    }
                case 2:
                    self.player.age = Int.random(in: 18...70)
                default:
                    break
                }
            case 1:
                switch indexPath.row {
                case 0:
                    self.player.job = RealmData.generateCharacterstic(objectType: JobsRealm.self, key: "job", index: nil)
                case 1:
                    self.player.jobExperience = Int.random(in:0...self.player.age)
                default:
                    break
                }
            case 2:
                self.player.health = RealmData.generateCharacterstic(objectType: HealthRealm.self, key: "health", index: nil)
            case 3:
                self.player.additionalInformation = RealmData.generateCharacterstic(objectType: AddInfoRealm.self, key: "additionalInformation", index: nil)
            case 4:
                self.player.hobby = RealmData.generateCharacterstic(objectType: HobbiesRealm.self, key: "hobby", index: nil)
            case 5:
                self.player.fear = RealmData.generateCharacterstic(objectType: FearsRealm.self, key: "fear", index: nil)
            case 6:
                self.player.baggage = RealmData.generateCharacterstic(objectType: BaggageRealm.self, key: "baggage", index: nil)
            case 7:
                self.player.treatOfCharacter = RealmData.generateCharacterstic(objectType: TreatsOfCharacterRealm.self, key: "characteristic", index: nil)
            default:
                break
            }
            let realm = try! Realm()
            try! realm.write {
                let player = PlayerInformationRealm()
                player.playerID = "\(self.playerNumber)"
                player.additionalInformation = self.player.additionalInformation
                player.baggage = self.player.baggage
                player.treatOfCharacter = self.player.treatOfCharacter
                player.fear = self.player.fear
                player.health = self.player.health
                player.hobby = self.player.hobby
                player.job = self.player.job
                player.jobExperience = self.player.jobExperience
                player.firstSpecialCard = self.player.firstSpecialCard
                player.secondSpecialCard = self.player.secondSpecialCard
                player.age = self.player.age
                player.sex = self.player.sex
                player.orientation = self.player.orientation
                realm.add(player, update: .all)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.dismiss()
            }
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: {_ in}))
        present(alert, animated: true, completion: nil)
        print("sdf")
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.5))
        footerView.backgroundColor = .systemBackground
        return footerView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        headerView.backgroundColor = .systemBackground
        let label = UILabel()
        label.numberOfLines = 1
        switch section {
        case 0:
            label.text = "Биологические характеристики"
        case 1:
            label.text = "Профессия"
        case 2:
            label.text = "Здоровье"
        case 3:
            label.text = "Дополнительная информация"
        case 4:
            label.text = "Хобби"
        case 5:
            label.text = "Фобия"
        case 6:
            label.text = "Багаж"
        case 7:
            label.text = "Черта характера"
        case 8:
            label.text = "Специальные карты"
        default:
            label.text = ""
        }
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        return headerView
    }
}
