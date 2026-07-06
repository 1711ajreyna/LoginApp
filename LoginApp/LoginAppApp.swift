//
//  LoginAppApp.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/3/26.
//


import SwiftUI

@main
struct LoginApp: App {
    @StateObject private var vm = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(vm)
        }
    }
}
