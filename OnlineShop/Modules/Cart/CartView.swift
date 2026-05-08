//
//  CartView.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CartView: UIView {
    
    // MARK: - Header
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - TableView
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Promo Code
    private let promoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let promoIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "tag.fill"))
        iv.tintColor = .systemOrange
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let promoTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Promo code"
        tf.font = .systemFont(ofSize: 15)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let applyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Apply", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        btn.tintColor = .primary
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Summary
    private let summaryCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shippingValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taxValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Checkout
    let checkoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .primaryDark
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(itemCountLabel)
        addSubview(tableView)
        addSubview(promoContainer)
        addSubview(summaryCard)
        addSubview(checkoutButton)
        
        setupPromo()
        setupSummary()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            itemCountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            itemCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 320),
            
            promoContainer.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            promoContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            promoContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            promoContainer.heightAnchor.constraint(equalToConstant: 48),
            
            summaryCard.topAnchor.constraint(equalTo: promoContainer.bottomAnchor, constant: 12),
            summaryCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            summaryCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            checkoutButton.topAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: 16),
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupPromo() {
        promoContainer.layer.borderWidth = 1
        promoContainer.layer.borderColor = UIColor.systemGray4.cgColor
        promoContainer.layer.cornerRadius = 10
        
        // Dashed border
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.systemGray4.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineDashPattern = [6, 4]
        shapeLayer.lineWidth = 1
        promoContainer.layer.addSublayer(shapeLayer)
        promoContainer.layer.borderWidth = 0
        
        promoContainer.addSubview(promoIcon)
        promoContainer.addSubview(promoTextField)
        promoContainer.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            promoIcon.leadingAnchor.constraint(equalTo: promoContainer.leadingAnchor, constant: 12),
            promoIcon.centerYAnchor.constraint(equalTo: promoContainer.centerYAnchor),
            promoIcon.widthAnchor.constraint(equalToConstant: 20),
            promoIcon.heightAnchor.constraint(equalToConstant: 20),
            
            promoTextField.leadingAnchor.constraint(equalTo: promoIcon.trailingAnchor, constant: 8),
            promoTextField.centerYAnchor.constraint(equalTo: promoContainer.centerYAnchor),
            promoTextField.trailingAnchor.constraint(equalTo: applyButton.leadingAnchor, constant: -8),
            
            applyButton.trailingAnchor.constraint(equalTo: promoContainer.trailingAnchor, constant: -12),
            applyButton.centerYAnchor.constraint(equalTo: promoContainer.centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update dashed border path
        if let shapeLayer = promoContainer.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer {
            shapeLayer.path = UIBezierPath(roundedRect: promoContainer.bounds, cornerRadius: 10).cgPath
        }
    }
    
    private func setupSummary() {
        let subtotalRow = makeSummaryRow(title: "Subtotal", valueLabel: subtotalValueLabel)
        let shippingRow = makeSummaryRow(title: "Shipping", valueLabel: shippingValueLabel)
        let taxRow = makeSummaryRow(title: "Tax", valueLabel: taxValueLabel)
        
        let separator = UIView()
        separator.backgroundColor = .systemGray4
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let totalTitleLabel = UILabel()
        totalTitleLabel.text = "Total"
        totalTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let totalRow = UIStackView(arrangedSubviews: [totalTitleLabel, totalValueLabel])
        totalRow.axis = .horizontal
        
        let stack = UIStackView(arrangedSubviews: [subtotalRow, shippingRow, taxRow, separator, totalRow])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        summaryCard.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: -16),
        ])
    }
    
    private func makeSummaryRow(title: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .gray
        
        let row = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        row.axis = .horizontal
        return row
    }
}
