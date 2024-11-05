//
//  HandmadenApp.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI
import FirebaseCore

//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct HandmadenApp: App {
    @StateObject private var userSession = UserSessionViewModel()

    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var savedViewModel = SavedViewModel()
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
                .environmentObject(userSession)
        }
    }
}
