//
//  AuthLoginViewController.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

public protocol AuthLoginViewControllerDelegate: class {
    func loginDidChange(_ login: String)
    func passwordDidChange(_ password: String)
    func loginButtonDidClicked()
}

public class AuthLoginViewController: UIViewController {
    
    var presenter: AuthLoginPresenter!
    
    var loginView: AuthLoginView {
        guard let view = self.view as? AuthLoginView else { fatalError() }
        return view
    }
    
    public override func loadView() {
        super.loadView()
        self.view = AuthLoginView()
    }
    
}

extension AuthLoginViewController: AuthLoginController {
    
    
    
}
