//
//  CustomerHomeViewController.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CustomerHomeViewController: UIViewController {
    
    private let homeView = CustomerHomeView()
    private let viewModel: CustomerHomeViewModel
    
    // MARK: - Init
    init(viewModel: CustomerHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupGreeting()
        setupCollectionViews()
        loadProducts()
    }
    
    // MARK: - Setup
    private func setupGreeting() {
        let name = UserDefaults.standard.customerName ?? "Guest"
        let firstName = name.components(separatedBy: " ").first ?? name
        homeView.greetingLabel.text = "Hi, \(firstName)!"
    }
    
    private func setupCollectionViews() {
        homeView.productsCollectionView.dataSource = self
        homeView.productsCollectionView.delegate = self
        homeView.productsCollectionView.register(
            CustomerProductCell.self,
            forCellWithReuseIdentifier: CustomerProductCell.identifier
        )
    }
    
    // MARK: - Data
    private func loadProducts() {
        viewModel.fetchProducts { [weak self] in
            self?.homeView.productsCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CustomerHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomerProductCell.identifier,
            for: indexPath
        ) as? CustomerProductCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.products[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CustomerHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let width = (collectionView.bounds.width - spacing) / 2
        return CGSize(width: width, height: width + 60)
    }
}
