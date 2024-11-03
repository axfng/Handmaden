//
//  HomeView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel


    var body: some View {
        NavigationStack {
            Text("Welcome to the Store")
                .font(.title)
                .padding()
        
            ScrollView {
                ForEach(productViewModel.products, id: \.id) { product in
                    ProductCardView(product: product)
                }
            }
        }
        .onAppear {
            Task {
                await productViewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
