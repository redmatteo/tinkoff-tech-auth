//
//  AuthLoginView.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

@available(iOS 11.0, *)
public class AuthLoginView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Авторизуйтесь"
        label.numberOfLines = 0
        return label
    }()
    
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
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.setBackgroundColor(color: .systemYellow, forState: .normal)
        button.setBackgroundColor(color: .lightGray, forState: .disabled)
        return button
    }()
    
    private(set) lazy var isSetPinCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.checkmarkStyle = .tick
        checkbox.checkedBorderColor = .systemYellow
        checkbox.borderCornerRadius = 7
        checkbox.uncheckedBorderColor = .lightGray
        checkbox.checkmarkColor = .systemYellow
        checkbox.useHapticFeedback = false
        return checkbox
    }()
    
    private(set) lazy var isSetPinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Задать PIN"
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(isSetPinLabelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gestureRecognizer)
        return label
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.alwaysBounceVertical = true
        return view
    }()
    
    private(set) lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func isSetPinLabelTapped() {
        isSetPinCheckbox.isChecked = !isSetPinCheckbox.isChecked
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(scrollContentView)
        self.scrollContentView.addSubview(titleLabel)
        self.scrollContentView.addSubview(loginField)
        self.scrollContentView.addSubview(passwordField)
        self.scrollContentView.addSubview(loginButton)
        self.scrollContentView.addSubview(isSetPinCheckbox)
        self.scrollContentView.addSubview(isSetPinLabel)
        configureUI()
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20.0
        let safeArea = self.safeAreaLayoutGuide
        
        // Scroll View
        let heightConstraint = self.scrollContentView.heightAnchor.constraint(equalTo: safeArea.heightAnchor)
        heightConstraint.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.scrollContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.scrollContentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            self.scrollContentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            self.scrollContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.scrollContentView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            heightConstraint
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollContentView.topAnchor, constant: padding),
            self.titleLabel.leftAnchor.constraint(equalTo: self.scrollContentView.leftAnchor, constant: padding),
            self.titleLabel.rightAnchor.constraint(equalTo: self.scrollContentView.rightAnchor, constant: padding * 2),
            
            self.loginField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: padding),
            self.loginField.leftAnchor.constraint(equalTo: self.scrollContentView.leftAnchor, constant: padding),
            self.loginField.centerXAnchor.constraint(equalTo: self.scrollContentView.centerXAnchor),
            self.loginField.heightAnchor.constraint(equalToConstant: 50),
            
            self.passwordField.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: padding),
            self.passwordField.leftAnchor.constraint(equalTo: self.loginField.leftAnchor),
            self.passwordField.centerXAnchor.constraint(equalTo: self.scrollContentView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            self.isSetPinCheckbox.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: padding),
            self.isSetPinCheckbox.leftAnchor.constraint(equalTo: self.passwordField.leftAnchor),
            self.isSetPinCheckbox.heightAnchor.constraint(equalToConstant: 25),
            self.isSetPinCheckbox.widthAnchor.constraint(equalToConstant: 25),
            
            self.isSetPinLabel.centerYAnchor.constraint(equalTo: self.isSetPinCheckbox.centerYAnchor),
            self.isSetPinLabel.leftAnchor.constraint(equalTo: self.isSetPinCheckbox.rightAnchor, constant: 10),
            self.isSetPinLabel.rightAnchor.constraint(equalTo: self.scrollContentView.rightAnchor, constant: -padding),
            
            self.loginButton.topAnchor.constraint(equalTo: self.isSetPinCheckbox.bottomAnchor, constant: padding),
            self.loginButton.centerXAnchor.constraint(equalTo: self.scrollContentView.centerXAnchor),
            self.loginButton.leftAnchor.constraint(equalTo: self.scrollContentView.leftAnchor, constant: padding),
            self.loginButton.bottomAnchor.constraint(lessThanOrEqualTo: self.scrollContentView.bottomAnchor, constant: -padding),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
