//
//  PlayerInfoViewController.swift
//  Sanctuary
//
//  Created by Valados on 10.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//

import UIKit

class PlayerInfoViewController: UIViewController {
    @IBOutlet weak var infoTextView: UITextView!
    var userInfo =  ""
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTextView.isEditable = false
        infoTextView.text = userInfo
    }
}
