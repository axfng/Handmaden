//
//  ContentView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                SavedView()
                    .tabItem {
                        Label("Saved", systemImage: "heart")
                    }
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
            }
        }
    }
}

#Preview {
    MainTabView()
}
