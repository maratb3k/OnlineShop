//
//  CartViewModel.swift
//  OnlineShop
//
//  Created by Assem Maratbek on 22.04.2026.
//

import Foundation

struct CartItem {
    let name: String
    let variant: String
    let price: Double
    var quantity: Int
}

class CartViewModel {
    
    var items: [CartItem] = [
        CartItem(name: "Linen tote bag", variant: "Natural · L", price: 45.00, quantity: 1),
        CartItem(name: "Ceramic mug set", variant: "Cream · set of 2", price: 64.00, quantity: 2),
        CartItem(name: "Oak cutting board", variant: "Medium", price: 88.00, quantity: 1),
    ]
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var subtotal: Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
    
    var shipping: Double { 6.00 }
    
    var tax: Double {
        subtotal * 0.043
    }
    
    var total: Double {
        subtotal + shipping + tax
    }
    
    func updateQuantity(at index: Int, quantity: Int) {
        guard index < items.count else { return }
        items[index].quantity = quantity
    }
}
