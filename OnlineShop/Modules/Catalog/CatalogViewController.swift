//
//  CatalogViewController.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let catalogView = CatalogView()
    private let viewModel: CatalogViewModel
    
    // MARK: - Init
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = catalogView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        catalogView.categoriesCollectionView.dataSource = self
        catalogView.categoriesCollectionView.delegate = self
        catalogView.categoriesCollectionView.register(
            CatalogCategoryCell.self,
            forCellWithReuseIdentifier: CatalogCategoryCell.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource
extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CatalogCategoryCell.identifier,
            for: indexPath
        ) as? CatalogCategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.categories[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let width = (collectionView.bounds.width - spacing) / 2
        return CGSize(width: width, height: width + 30)
    }
}
