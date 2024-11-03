//
//  SavedViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import FirebaseFirestore
import FirebaseAuth
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
            likedProduct.isLiked.toggle()
            savedItems.append(likedProduct)
//            updateLikedItemsInFirestore()
        }
    }
    
    func isLiked(_ product: Product) -> Bool {
        savedItems.contains(where: { $0.id == product.id })
    }
    
//    private func updateLikedItemsInFirestore() {
//            guard let userId = Auth.auth().currentUser?.uid else { return }
//            let db = Firestore.firestore()
//            
//            let likedItemIDs = savedItems.map { $0.id } // Extract just the product IDs
//            
//            db.collection("users").document(userId).updateData(["likedItems": likedItemIDs]) { error in
//                if let error = error {
//                    print("Error updating liked items: \(error)")
//                } else {
//                    print("Liked items successfully updated.")
//                }
//            }
//        }
//        
//    func loadLikedItemsFromFirestore() async {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let db = Firestore.firestore()
//        
//        do {
//            let document = try await db.collection("users").document(userId).getDocument()
//            if let data = document.data(), let likedItemIDs = data["likedItems"] as? [Int] {
//                // Fetch full product data for each liked item ID
//                self.savedItems = await fetchProducts(by: likedItemIDs)
//            }
//        } catch {
//            print("Error loading liked items: \(error)")
//        }
//    }
//    
//    private func fetchProducts(by ids: [Int]) async -> [Product] {
//            // Implement logic to fetch product details from Firestore or your API
//            // This could be a batch request to retrieve the full product data
//            return [] // Replace with actual fetch logic
//    }
}
