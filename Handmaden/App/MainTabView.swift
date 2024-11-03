//
//  ContentView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var savedViewModel = SavedViewModel() 


    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
        
        }
    }
}

#Preview {
    MainTabView()
}
