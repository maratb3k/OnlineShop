//
//  LoginView.swift
//  Turmys App
//
//  Created by Yerkezhan Zheneessova on 10.04.2025.
//
import UIKit

class LoginView: UIView{
    let loginTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "Логин"
        return textField
    }()
    
    let passwordTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "Пароль"
        return textField
    }()
    
    let loginButton: MainButton = {
        let button = MainButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .turmysTerracotta
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setEnabled(false)
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .turmysTerracotta
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    let noAccountButton : MainButton = {
        let button = MainButton(type: .system)
        button.setTitle("У меня нет аккаунта/Зарегистрироваться", for: .normal)
        button.setTitleColor(.turmysTerracotta, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .turmysIvory
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [loginTextField, passwordTextField, errorLabel, loginButton, noAccountButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),

            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
