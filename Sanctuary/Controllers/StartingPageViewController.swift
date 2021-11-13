//
//  NewGameViewController.swift
//  Sanctuary
//
//  Created by Valados on 13.11.2021.
//  Copyright © 2021 Valados. All rights reserved.
//

import UIKit

class StartingPageViewController: UIViewController {
    
    private var players = 1
    
    var delegate: isAbleToReceiveData!
    
    private let newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Новая игра", for: .normal)
        button.backgroundColor = UIColor.darkRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    private let gameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sanctuary")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playersCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество игроков: 1"
        label.textColor = UIColor.darkRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playersCountStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 20
        stepper.minimumValue = 1
        stepper.stepValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(gameImage)
        view.addSubview(newGameButton)
        stackView.addArrangedSubview(playersCountLabel)
        stackView.addArrangedSubview(playersCountStepper)
        view.addSubview(stackView)
        
        playersCountStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        newGameButton.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        
        activateConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.pass(numberOfPlayers: players)
    }
    
    @objc func newGameButtonPressed(){
        UserDefaults.standard.setValue(true, forKey: "GameIsCreated")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper){
        players = Int(sender.value)
        playersCountLabel.text = "Количество игроков: \(players)"
        print("Количество игроков: \(players)")
    }
    private func activateConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(gameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100))
        constraints.append(gameImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(gameImage.widthAnchor.constraint(equalToConstant: 220))
        constraints.append(gameImage.heightAnchor.constraint(equalToConstant: 220))
        
        constraints.append(stackView.topAnchor.constraint(equalTo: gameImage.bottomAnchor, constant: 100))
        constraints.append(stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30))
        constraints.append(stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30))

        constraints.append(newGameButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20))
        constraints.append(newGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30))
        constraints.append(newGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30))
        constraints.append(newGameButton.heightAnchor.constraint(equalToConstant: 40))
        
        NSLayoutConstraint.activate(constraints)
    }
}
