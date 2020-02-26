//
//  ViewController.swift
//  AuthPinScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthPinScreen

class ViewController: AuthPinController, AuthPinControllerDelegate {

    let testPin = "1111"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController()
        delegate = self
//        delegate?.state = .setPin
        delegate?.state = .confirmPin(testPin)
    }
    
    func setupAuthPinController() {
        let authPinBundle = Bundle(for: AuthPinController.self)
        if let authPinController = authPinBundle.loadNibNamed("AuthPinController", owner: self, options: nil)?.first as? AuthPinController {
            navigationController?.pushViewController(authPinController, animated: true)
        }
    }
    
    //if state is setPin
    func didSetNewPin(_ pin: String) {
        print("Success set new PIN = \(pin)")
    }
    
    //if state is confirmPin
    func didSuccessSignIn() {
        print("Success Sign in")
    }
    
    func didTouchSkipBtn() {
        print("Touch Skip Btn")
    }
    
}

