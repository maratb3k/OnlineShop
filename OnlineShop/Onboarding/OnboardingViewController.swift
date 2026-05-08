//
//  OnboardingViewController.swift
//  Turmys App
//
//  Created by Yerkezhan Zheneessova on 03.04.2025.
//

import UIKit

class OnboardingViewController: UIViewController{
    
    var onContinue: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Как это работает?"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .turmysSage
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Опубликуйте задание, которое нужно сделать по дому, и выберите цену, которую вы готовы заплатить. Работники ответят предложениями, а вы выберете лучшее"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .turmysSage
        label.textAlignment = .center
        label.numberOfLines = 0
        return label

    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .turmysTerracotta
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .turmysIvory
        setupLayout()
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        
    }
    
    @objc
    private func didTapContinue(){
        onContinue?()
    }
    
    func setupLayout(){
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(continueButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
