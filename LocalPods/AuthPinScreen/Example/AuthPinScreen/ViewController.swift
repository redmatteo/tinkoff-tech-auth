//
//  ViewController.swift
//  AuthPinScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthPinScreen

class ViewController: UIViewController, AuthPinControllerDelegate {

    let testPin = "1111"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController()
    }
    
    func setupAuthPinController() {
        guard let controller = AuthPinController.new() else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //if state is setPin
    func didSetNewPin(_ pin: String) {
        print("Success set new PIN = \(pin)")
    }
    
    //if state is confirmPin
    func didSuccessSignIn() {
        print("Success Sign in")
    }
    
}

