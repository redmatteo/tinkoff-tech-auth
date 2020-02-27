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
            case .confirmPin(let code):
                self?.runConfirmPin(code)
            }
        }
    }
    
    private func runLogin() {
        let login = AuthLoginViewController()
        login.delegate = self
        setViewControllers([login], animated: true)
    }
    
    private func runConfirmPin(_ code: String) {
        let pin = AuthPin()
        pin.delegate = self
        pin.state = .confirmPin(code)
        setViewControllers([pin], animated: true)
    }
    
    private func runSetPinIfNeeded(_ needPin: Bool) {
        guard needPin else {
            runContent()
            return
        }
        let authPin = AuthPin()
        authPin.delegate = self
        authPin.state = .setPin
        setViewControllers([authPin], animated: false)
    }

    private func runContent() {
        guard let content = R.storyboard.main.contentController() else { return }
        setViewControllers([content], animated: true)
    }
    
    private func sendCredentials(_ credentials: Credentials) {
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
    }
    
    private func sendNewPin(_ code: String) {
        auth.sendPin(code: code)
    }
        
    func dismissContent() {
        auth.resetCredentials()
        runLogin()
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
        guard let code = Int(pin) else { return }
        
        sendNewPin(pin)
        runContent()
    }
    
    func didSuccessSignIn() {
        runContent()
    }
    
    func didTouchSkipBtn() {
        runContent()
    }
}
