//
//  ViewController.swift
//  AuthPinScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthPinScreen

class ViewController: AuthPinController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController(with: .confirmPin)
    }
    
    func setupAuthPinController(with state: AuthPinState) {
        let authPinBundle = Bundle(for: AuthPinController.self)
        if let authPinController = authPinBundle.loadNibNamed("AuthPinController", owner: self, options: nil)?.first as? AuthPinController {
            authPinController.state = state
            navigationController?.pushViewController(authPinController, animated: true)
        }
    }
    
}

