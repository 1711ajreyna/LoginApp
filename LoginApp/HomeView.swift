//
//  HomeView.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/3/26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var vm: AuthViewModel

    var body: some View {
        VStack(spacing: 24) {

            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)
                .accessibilityIdentifier("homeIcon")

            Text("Welcome, \(vm.loggedInUsername)!")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("welcomeLabel")

            Text("You are now logged in.")
                .foregroundStyle(.secondary)

            Button(action: { vm.logout() }) {
                Text("Log Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            .accessibilityIdentifier("logoutButton")

            Spacer()
        }
        .padding(.top, 80)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let vm = AuthViewModel()
    vm.loggedInUsername = "Student"
    return HomeView().environmentObject(vm)
}
