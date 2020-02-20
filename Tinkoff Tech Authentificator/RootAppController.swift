//
//  RootAppController.swift
//  Tinkoff Tech Authentificator
//
//  Created by Mikhail on 20.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager

private typealias Credentials = (login: String, password: String)

class RootAppController: UINavigationController {
    private lazy var auth = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthState()
    }
    
    private func checkAuthState() {
        auth.authentificate { [weak self] state in
            switch state {
            case .credentials:
                self?.runLogin()
            case .setPin:
                self?.runSetPin()
            case .confirmPin:
                self?.runConfirmPin()
            }
        }
    }
    
    private func runLogin() {
        // TODO AuthLoginScreen
        
        let credentials: Credentials = (login: "fakelogin", password: "12345678")
        sendCredentials(credentials)
    }
    
    private func runSetPin() {
        // TODO AuthLoginScreen
    }
    
    private func runConfirmPin() {
        // TODO AuthLoginScreen
    }
    
    private func sendCredentials(_ credentials: Credentials) {
        
    }
    
    private func sendNewPinCode() {
    
    }
    
    private func sendPinCode() {
        
    }
}
