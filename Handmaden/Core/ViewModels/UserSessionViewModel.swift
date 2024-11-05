//
//  UserSessionViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserSessionViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var cart: [CartItem] = []
    @Published var savedList: [Product] = []
    private let db = Firestore.firestore()
    
    init() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
            loadUserData() // Load data if the user is already logged in
        } else {
            isLoggedIn = false
        }
    }

    func saveUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        // Convert CartItem objects to Firestore-compatible dictionaries
        let cartData = cart.map { cartItem in
            return [
                "id": cartItem.id,
                "quantity": cartItem.quantity,
                "product": [
                    "id": cartItem.product.id,
                    "title": cartItem.product.title,
                    "description": cartItem.product.description,
                    "price": cartItem.product.price,
                    "thumbnail": cartItem.product.thumbnail,
                    "tags": cartItem.product.tags,
                    "isLiked": cartItem.product.isLiked
                ]
            ] as [String: Any]
        }

        // Convert Product objects in savedList to Firestore-compatible dictionaries
        let savedListData = savedList.map { product in
            return [
                "id": product.id,
                "title": product.title,
                "description": product.description,
                "price": product.price,
                "thumbnail": product.thumbnail,
                "tags": product.tags,
                "isLiked": product.isLiked
            ] as [String: Any]
        }

        // Save cart and savedList to Firestore under the user's document
        db.collection("users").document(userId).setData([
            "cart": cartData,
            "savedList": savedListData
        ], merge: true) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data successfully saved to Firestore")
            }
        }
    }
    
    func loadUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(userId).getDocument { document, error in
            guard let document = document, document.exists else {
                print("User document not found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Parse cart data
            if let cartData = document.data()?["cart"] as? [[String: Any]] {
                self.cart = cartData.compactMap { itemData in
                    guard
                        let id = itemData["id"] as? Int,
                        let quantity = itemData["quantity"] as? Int,
                        let productData = itemData["product"] as? [String: Any],
                        let productId = productData["id"] as? Int,
                        let title = productData["title"] as? String,
                        let description = productData["description"] as? String,
                        let price = productData["price"] as? Double,
                        let thumbnail = productData["thumbnail"] as? String,
                        let tags = productData["tags"] as? [String],
                        let isLiked = productData["isLiked"] as? Bool
                    else {
                        return nil
                    }

                    let product = Product(id: productId, title: title, description: description, price: price, thumbnail: thumbnail, tags: tags, isLiked: isLiked)
                    return CartItem(id: id, product: product, quantity: quantity)
                }
            }

            // Parse savedList data
            if let savedListData = document.data()?["savedList"] as? [[String: Any]] {
                self.savedList = savedListData.compactMap { productData in
                    guard
                        let id = productData["id"] as? Int,
                        let title = productData["title"] as? String,
                        let description = productData["description"] as? String,
                        let price = productData["price"] as? Double,
                        let thumbnail = productData["thumbnail"] as? String,
                        let tags = productData["tags"] as? [String],
                        let isLiked = productData["isLiked"] as? Bool
                    else {
                        return nil
                    }
                    return Product(id: id, title: title, description: description, price: price, thumbnail: thumbnail, tags: tags, isLiked: isLiked)
                }
            }

            print("User data successfully loaded from Firestore")
        }
    }
    
    func logOut() {
        saveUserData() // Save data before logging out
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }
    
    func logIn() {
        // Logic for successful login
        loadUserData() // Load user's saved data from Firestore
        self.isLoggedIn = true
    }
    
}
