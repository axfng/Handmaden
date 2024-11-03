//
//  RootView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct RootView: View {
    @State private var loadScreen = true
    @EnvironmentObject var viewModel: AuthViewModel

 
    var body: some View {
        Group {
            if loadScreen {
                LoadingView()
                    .transition(.opacity)
            } else {
                if viewModel.userSession != nil {
                    MainTabView()
                } else {
                    LoginView()
                } 
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    loadScreen.toggle()
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
}
