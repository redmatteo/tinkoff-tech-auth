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
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private(set) lazy var isSetPinCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.checkmarkStyle = .tick
        return checkbox
    }()
    
    private(set) lazy var isSetPinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Задать PIN"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(loginField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
        self.addSubview(isSetPinCheckbox)
        self.addSubview(isSetPinLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let topPadding: CGFloat = 100.0
        let padding: CGFloat = 40.0
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.loginField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding + topPadding),
            self.loginField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: padding),
            self.loginField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            self.passwordField.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: padding),
            self.passwordField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: padding),
            self.passwordField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            self.isSetPinCheckbox.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: padding),
            self.isSetPinCheckbox.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: padding),
            self.isSetPinCheckbox.heightAnchor.constraint(equalToConstant: 25),
            self.isSetPinCheckbox.widthAnchor.constraint(equalToConstant: 25),
            
            self.isSetPinLabel.centerYAnchor.constraint(equalTo: self.isSetPinCheckbox.centerYAnchor),
            self.isSetPinLabel.leftAnchor.constraint(equalTo: self.isSetPinCheckbox.rightAnchor, constant: 10),
            self.isSetPinLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -padding),
            
            self.loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}
