//
//  RandomCharacteristicsViewController.swift
//  Sanctuary
//
//  Created by Valados on 14.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import UIKit
import RealmSwift

class RandomCharacteristicsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        activateConstraints()
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
extension RandomCharacteristicsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 2
        }
        else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Ориентация"
            case 1:
                cell.textLabel?.text = "Возраст"
            default:
                cell.textLabel?.text = ""
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Профессия"
            case 1:
                cell.textLabel?.text = "Опыт работы"
            default:
                break
            }
        case 2:
            cell.textLabel?.text = "Хобби"
        case 3:
            cell.textLabel?.text = "Здоровье"
        case 4:
            cell.textLabel?.text = "Фобия"
        case 5:
            cell.textLabel?.text = "Багаж"
        case 6:
            cell.textLabel?.text = "Дополнительная информация"
        case 7:
            cell.textLabel?.text = "Черта характера"
        default:
            break
        }
        cell.accessoryType = .detailButton
        cell.tintColor = UIColor.darkRed
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var newInformation = ""
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                newInformation = "Возраст:\(Int.random(in: 18...70))"
            case 1:
                switch Int.random(in: 0...2){
                case 0:
                    newInformation = "Гомосексуальность"
                case 1:
                    newInformation = "Гетеросексуальность"
                case 2:
                    newInformation = "Бисексуальность"
                default:
                    break
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                newInformation = RealmData.generateCharacterstic(objectType: JobsRealm.self, key: "job", index: nil)
            case 1:
                newInformation = "Опыт работы:\(Int.random(in:0...30))"
            default:
                break
            }
        case 2:
            newInformation = RealmData.generateCharacterstic(objectType: HobbiesRealm.self, key: "hobby", index: nil)
        case 3:
            newInformation = RealmData.generateCharacterstic(objectType: HealthRealm.self, key: "health", index: nil)
        case 4:
            newInformation = RealmData.generateCharacterstic(objectType: FearsRealm.self, key: "fear", index: nil)
        case 5:
            newInformation = RealmData.generateCharacterstic(objectType: BaggageRealm.self, key: "baggage", index: nil)
        case 6:
            newInformation = RealmData.generateCharacterstic(objectType: AddInfoRealm.self, key: "additionalInformation", index: nil)
        case 7:
            newInformation = RealmData.generateCharacterstic(objectType: TreatsOfCharacterRealm.self, key: "characteristic", index: nil)
        default:
            break
        }
        let alert = UIAlertController(title: newInformation, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: {_ in}))
        present(alert, animated: true, completion: nil)
    }
}
