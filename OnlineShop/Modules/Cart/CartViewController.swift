//
//  CartViewController.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CartViewController: UIViewController {
    
    private let cartView = CartView()
    private let viewModel: CartViewModel
    
    // MARK: - Init
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupTableView()
        updateSummary()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        cartView.tableView.register(
            CartItemCell.self,
            forCellReuseIdentifier: CartItemCell.identifier
        )
    }
    
    private func updateSummary() {
        cartView.itemCountLabel.text = "\(viewModel.itemCount) items"
        cartView.subtotalValueLabel.text = String(format: "$%.2f", viewModel.subtotal)
        cartView.shippingValueLabel.text = String(format: "$%.2f", viewModel.shipping)
        cartView.taxValueLabel.text = String(format: "$%.2f", viewModel.tax)
        cartView.totalValueLabel.text = String(format: "$%.2f", viewModel.total)
        cartView.checkoutButton.setTitle(String(format: "Checkout · $%.2f", viewModel.total), for: .normal)
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartItemCell.identifier,
            for: indexPath
        ) as? CartItemCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.items[indexPath.row]
        cell.configure(name: item.name, variant: item.variant, price: item.price, quantity: item.quantity)
        cell.onQuantityChanged = { [weak self] newQuantity in
            self?.viewModel.updateQuantity(at: indexPath.row, quantity: newQuantity)
            self?.updateSummary()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}
