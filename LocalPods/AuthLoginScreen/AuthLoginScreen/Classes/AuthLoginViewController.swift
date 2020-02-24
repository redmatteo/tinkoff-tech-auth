//
//  AuthLoginViewController.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

import RxSwift
import RxCocoa
import Validator

public protocol AuthLoginViewControllerDelegate: class {
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool)
}

@available(iOS 11.0, *)
open class AuthLoginViewController: LoadingViewController {
    
    public var delegate: AuthLoginViewControllerDelegate?
    
    public var loginView: AuthLoginView {
        guard let view = self.view as? AuthLoginView else { fatalError() }
        return view
    }
    
    public override func loadView() {
        super.loadView()
        self.view = AuthLoginView()
        self.loginView.loginButton.addTarget(self, action: #selector(loginButtonDidClicked), for: .touchUpInside)
        self.loginView.loginField.delegate = self
        self.loginView.passwordField.delegate = self
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        activateValidator()
    }
    
    @objc
    func loginButtonDidClicked() {
        let login = self.loginView.loginField.text ?? ""
        let password = self.loginView.passwordField.text ?? ""
        let isSetPin = self.loginView.isSetPinCheckbox.isChecked
        self.delegate?.loginButtonDidClicked(login: login, password: password, isSetPin: isSetPin)
    }
    
    private func activateValidator() {
        let view = self.loginView
        _ = Observable.combineLatest(view.loginField.rx.text, view.passwordField.rx.text)
            .map { login, password in
                return (login ?? "").validate(rules: AuthLoginValidator.loginValidateRules).isValid &&
                    (password ?? "").validate(rules: AuthLoginValidator.passwordValidateRules).isValid
        }.bind { isValid in
            view.loginButton.isEnabled = isValid
        }
    }
    
}

@available(iOS 11.0, *)
extension AuthLoginViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1
        if let nextResponder = self.loginView.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
