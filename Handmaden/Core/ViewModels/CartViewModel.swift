//
//  CartViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func addToCart(product: Product) {
            if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
                cartItems[index].quantity += 1
            } else {
                cartItems.append(CartItem(id: product.id, product: product, quantity: 1))
            }
        }
        
    func removeFromCart(product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
    var totalCost: Double {
        cartItems.reduce(0) { $0 + $1.totalPrice }
    }
    
    var totalItems: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
}
