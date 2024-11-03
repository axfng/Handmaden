//
//  RootView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct RootView: View {
    @State private var loadScreen = true
    
    var body: some View {
        Group {
            if loadScreen {
                LoadingView()
                    .transition(.opacity)
            } else {
                TabView()
                    .transition(.opacity)
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
}
