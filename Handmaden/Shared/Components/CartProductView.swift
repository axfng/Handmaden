//
//  CartProductView.swift
//  Handmaden
//
//  Created by alfeng on 11/3/24.
//

import SwiftUI

struct CartProductView: View {
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel

    let cartItem: CartItem

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: cartItem.product.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Image load error")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 5) {
                Text(cartItem.product.title)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(cartItem.product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Quantity: \(cartItem.quantity)")
                    .font(.subheadline)
                Text("Total: \(cartItem.totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 4)

                HStack {
                    Button(action: {
                        cartViewModel.removeFromCart(product: cartItem.product)
                    }) {
                        Text("Remove")
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        savedViewModel.toggleLike(for: cartItem.product)
                    }) {
                        Image(systemName: savedViewModel.isLiked(cartItem.product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let mockProduct = Product(id: 1, title: "Sample Product", description: "A great product", price: 19.99, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png", tags: ["Beauty"])
    return CartProductView(cartItem: CartItem(id: 1, product: mockProduct, quantity: 2))
        .environmentObject(SavedViewModel())
        .environmentObject(CartViewModel())
}
