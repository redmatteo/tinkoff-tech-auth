//
//  RootAppController.swift
//  Tinkoff Tech Authentificator
//
//  Created by Mikhail on 20.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager
import AuthLoginScreen
import AuthPinScreen

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
            case .confirmPin:
                self?.runConfirmPin()
            }
        }
    }
    
    private func runLogin() {
        let login = AuthLoginViewController()
        login.delegate = self
        setViewControllers([login], animated: true)
    }
    
    private func runConfirmPin() {
        // TODO AuthLoginScreen
    }
    
    private func runSetPinIfNeeded(_ needPin: Bool) {
        guard needPin else {
            runContent()
            return
        }
        guard let pin = AuthPinController.new() else { return }
        pin.delegate = self
        pin.state = .setPin
        setViewControllers([pin], animated: true)
    }

    private func runContent() {
        guard let content = R.storyboard.main.contentController() else { return }
        setViewControllers([content], animated: true)
    }
    
    private func sendCredentials(_ credentials: Credentials) {
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
    }
    
    private func sendNewPin(_ code: String) {
    
    }
    
    private func sendConfirmPin(_ code: String) {
        
    }
}

// MARK: AuthLoginViewControllerDelegate
extension RootAppController: AuthLoginViewControllerDelegate {
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool) {
        sendCredentials((login, password))
        guard let login = viewControllers.first as? AuthLoginViewController else { return }
        login.openLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) { [weak self] in
            login.closeLoadingView()
            self?.runSetPinIfNeeded(isSetPin)
        }
    }
}

extension RootAppController: AuthPinControllerDelegate {
    var state: AuthPinState {
        get {
            .setPin
        }
        set(newValue) {
            
        }
    }
    
    func didSetNewPin(_ pin: String) {
        sendNewPin(pin)
    }
    
    func didSuccessSignIn() {
        
    }
    
    func didTouchSkipBtn() {
        
    }
}
