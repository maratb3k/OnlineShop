//
//  CatalogView.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import UIKit

class CatalogView: UIView {
    
    // MARK: - Title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Catalog"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Search
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search products",
            attributes: [.foregroundColor: UIColor.secondary]
        )
        sb.searchBarStyle = .minimal
        sb.tintColor = .primary
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    // MARK: - Categories
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        searchBar.searchTextField.leftView?.tintColor = .primary
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(categoriesCollectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
