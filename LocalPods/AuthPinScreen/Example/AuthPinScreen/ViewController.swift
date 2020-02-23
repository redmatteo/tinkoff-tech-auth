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
        if let authPinController = createAuthPinController() {
            navigationController?.pushViewController(authPinController, animated: true)
        }
        
    }
    
}

