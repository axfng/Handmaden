//
//  CartItem.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: Int // This should match the Product ID for easy lookup
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        return Double(quantity) * product.price
    }
}
