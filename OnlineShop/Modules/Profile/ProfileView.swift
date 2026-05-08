//
//  ProfileView.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 13.04.2026.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - ScrollView
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Avatar
    let avatarImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.image = UIImage(named: "avatar_placeholder")
        return img
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .primary
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondary
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Shortcut Cards
    private let shortcutsGrid: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Menu List
    private let menuCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let menuStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupShortcuts()
        setupMenu()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Shortcuts
    private func setupShortcuts() {
        let items: [(String, String, String)] = [
            ("shippingbox", "Orders", "12"),
            ("arrow.uturn.left", "Returns", "1"),
            ("heart.fill", "Saved", "48"),
            ("star.fill", "Reviews", "3"),
            ("tag", "Coupons", "5"),
            ("gift", "Rewards", ""),
        ]
        
        let row1 = makeShortcutRow(items: Array(items[0..<3]))
        let row2 = makeShortcutRow(items: Array(items[3..<6]))
        shortcutsGrid.addArrangedSubview(row1)
        shortcutsGrid.addArrangedSubview(row2)
    }
    
    private func makeShortcutRow(items: [(String, String, String)]) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 12
        row.distribution = .fillEqually
        
        for item in items {
            let card = makeShortcutCard(icon: item.0, title: item.1, count: item.2)
            row.addArrangedSubview(card)
        }
        return row
    }
    
    private func makeShortcutCard(icon: String, title: String, count: String) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 12
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .primaryDark
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let countLabel = UILabel()
        countLabel.text = count
        countLabel.font = .systemFont(ofSize: 12)
        countLabel.textColor = .gray
        countLabel.textAlignment = .center
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(iconView)
        card.addSubview(titleLabel)
        card.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 90),
            
            iconView.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            iconView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6),
            titleLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            countLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
        ])
        
        return card
    }
    
    // MARK: - Menu
    private func setupMenu() {
        let items = ["Addresses", "Payment", "Notifications", "Help"]
        
        for (index, title) in items.enumerated() {
            let row = makeMenuRow(title: title)
            menuStack.addArrangedSubview(row)
            
            if index < items.count - 1 {
                let separator = UIView()
                separator.backgroundColor = .systemGray5
                separator.translatesAutoresizingMaskIntoConstraints = false
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                menuStack.addArrangedSubview(separator)
            }
        }
        
        menuCard.addSubview(menuStack)
        NSLayoutConstraint.activate([
            menuStack.topAnchor.constraint(equalTo: menuCard.topAnchor),
            menuStack.leadingAnchor.constraint(equalTo: menuCard.leadingAnchor),
            menuStack.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor),
            menuStack.bottomAnchor.constraint(equalTo: menuCard.bottomAnchor),
        ])
    }
    
    private func makeMenuRow(title: String) -> UIView {
        let row = UIView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .gray
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        row.addSubview(label)
        row.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: 16),
            
            chevron.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -16),
        ])
        
        return row
    }

    // MARK: - Layout
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [avatarImg, nameLabel, roleLabel].forEach { stackView.addArrangedSubview($0) }
        contentView.addSubview(stackView)
        contentView.addSubview(addPhotoButton)
        contentView.addSubview(shortcutsGrid)
        contentView.addSubview(menuCard)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            addPhotoButton.widthAnchor.constraint(equalToConstant: 30),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 30),
            addPhotoButton.bottomAnchor.constraint(equalTo: avatarImg.bottomAnchor),
            addPhotoButton.trailingAnchor.constraint(equalTo: avatarImg.trailingAnchor),
            
            shortcutsGrid.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            shortcutsGrid.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shortcutsGrid.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            menuCard.topAnchor.constraint(equalTo: shortcutsGrid.bottomAnchor, constant: 20),
            menuCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            menuCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            menuCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
