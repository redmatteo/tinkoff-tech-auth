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
    func isSetPinDidChange(_ isSetPin: Bool)
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool)
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
        view.loginButton.addTarget(self, action: #selector(loginButtonDidClicked), for: .touchUpInside)
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        activateValidator()
        setBindings()
    }
    
    private func setBindings() {
        _ = self.loginView.loginField.rx.text.bind { login in
            self.delegate?.loginDidChange(login ?? "")
        }
        _ = self.loginView.passwordField.rx.text.bind { password in
            self.delegate?.passwordDidChange(password ?? "")
        }
        _ = self.loginView.isSetPinCheckbox.rx.controlProperty(
            editingEvents: .valueChanged,
            getter: { (checkbox) -> Bool in
            return checkbox.isChecked
        }) { _,_ in }.bind { isChecked in
            self.delegate?.isSetPinDidChange(isChecked)
        }
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
extension AuthLoginViewController: AuthLoginController {
    
    
    
}
