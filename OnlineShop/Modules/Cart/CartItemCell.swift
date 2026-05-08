//
//  CartItemCell.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    static let identifier = "CartItemCell"
    
    var onQuantityChanged: ((Int) -> Void)?
    private var quantity = 1
    
    // MARK: - UI
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let variantLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("−", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.tintColor = .label
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.tintColor = .label
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        contentView.addSubview(cardView)
        cardView.addSubview(productImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(variantLabel)
        cardView.addSubview(priceLabel)
        cardView.addSubview(minusButton)
        cardView.addSubview(quantityLabel)
        cardView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            productImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            productImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            productImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            variantLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            variantLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -14),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            plusButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -14),
            plusButton.widthAnchor.constraint(equalToConstant: 28),
            plusButton.heightAnchor.constraint(equalToConstant: 28),
            
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8),
            quantityLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 20),
            
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -8),
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 28),
            minusButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    // MARK: - Actions
    private func setupActions() {
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
    }
    
    @objc private func minusTapped() {
        guard quantity > 1 else { return }
        quantity -= 1
        quantityLabel.text = "\(quantity)"
        onQuantityChanged?(quantity)
    }
    
    @objc private func plusTapped() {
        quantity += 1
        quantityLabel.text = "\(quantity)"
        onQuantityChanged?(quantity)
    }
    
    // MARK: - Configure
    func configure(name: String, variant: String, price: Double, quantity: Int) {
        nameLabel.text = name
        variantLabel.text = variant
        priceLabel.text = "\(Int(price)) ₸"
        self.quantity = quantity
        quantityLabel.text = "\(quantity)"
    }
}
