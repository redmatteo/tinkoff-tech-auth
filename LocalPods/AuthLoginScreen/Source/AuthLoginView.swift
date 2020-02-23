//
//  AuthLoginView.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

@available(iOS 11.0, *)
class AuthLoginView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Login"
        field.textContentType = .username
        return field
    }()
    
    private(set) lazy var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.textContentType = .password
        return field
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func setupLayout() {
        self.addSubview(loginField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20.0
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.loginField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            self.loginField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            self.passwordField.topAnchor.constraint(equalTo: self.loginField.topAnchor, constant: padding),
            self.passwordField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            self.loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}
