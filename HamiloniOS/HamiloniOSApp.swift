//
//  HamiloniOSApp.swift
//  HamiloniOS
//
//  Created by 한설 on 2025/07/23.
//

import SwiftUI

@main
struct HamiloniOSApp: App {
    @StateObject var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            if authManager.isLoggedIn {
                MainView()
                    .environmentObject(authManager)
            } else {
                SignInView()
                    .environmentObject(authManager)
            }
        }
    }
}
