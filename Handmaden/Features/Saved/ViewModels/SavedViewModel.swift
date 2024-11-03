//
//  SavedViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation
import SwiftUI

@MainActor
class SavedViewModel: ObservableObject {
    @Published var savedItems: [Product] = []

    func toggleLike(for product: Product) {
        if let index = savedItems.firstIndex(where: { $0.id == product.id }) {
            savedItems.remove(at: index)
        } else {
            var likedProduct = product
            likedProduct.isLiked.toggle() // Update the liked status
            savedItems.append(likedProduct)
        }
    }

    func isLiked(_ product: Product) -> Bool {
        savedItems.contains(where: { $0.id == product.id })
    }
}
