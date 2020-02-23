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
    func loginDidChange(_ login: String)
    func passwordDidChange(_ password: String)
    func loginButtonDidClicked()
}

@available(iOS 11.0, *)
public class AuthLoginViewController: UIViewController {
    
    var presenter: AuthLoginPresenter!
    public var delegate: AuthLoginViewControllerDelegate?
    
    var loginView: AuthLoginView {
        guard let view = self.view as? AuthLoginView else { fatalError() }
        return view
    }
    
    public override func loadView() {
        super.loadView()
        let view = AuthLoginView()
        view.loginField.delegate = self
        view.passwordField.delegate = self
        view.loginButton.addTarget(self, action: #selector(loginButtonDidClicked), for: .touchUpInside)
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        activateValidator()
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
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text,
            let delegate = self.delegate else { return }
        switch textField {
        case let field where field == self.loginView.loginField:
            delegate.loginDidChange(text)
        case let field where field == self.loginView.passwordField:
            delegate.passwordDidChange(text)
        default: break
        }
    }
    
    @objc
    func loginButtonDidClicked() {
        self.delegate?.loginButtonDidClicked()
    }
    
}

@available(iOS 11.0, *)
extension AuthLoginViewController: AuthLoginController {
    
    
    
}
