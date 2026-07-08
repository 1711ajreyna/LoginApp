//
//   LoginView.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/6/26.
//


import SwiftUI

struct LoginView: View {

    @EnvironmentObject var vm: AuthViewModel
    @State private var showRegistration = false

    var body: some View {
        NavigationStack {
            ScrollView {  // makes content scrollable when keyboard appears
                VStack(spacing: 24) {

                    // -- Header --
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 72))
                        .foregroundStyle(.blue)
                        .accessibilityIdentifier("loginIcon")

                    Text("Welcome Back")
                        .font(.largeTitle.bold())

                    Text("Sign in to continue")
                        .foregroundStyle(.secondary)

                    // -- Fields --
                    VStack(spacing: 16) {
                        TextField("Email", text: $vm.loginEmail)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .accessibilityIdentifier("loginEmailField")

                        SecureField("Password", text: $vm.loginPassword)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("loginPasswordField")
                    }
                    .padding(.horizontal)

                    // -- Error message --
                    if !vm.loginError.isEmpty {
                        Text(vm.loginError)
                            .foregroundStyle(.red)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .accessibilityIdentifier("loginErrorLabel")
                    }

                    // -- Login button --
                    Button(action: { vm.login() }) {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)
                    .accessibilityIdentifier("loginButton")

                    // -- Go to Registration --
                    Button(action: { showRegistration = true }) {
                        Text("Don't have an account? **Register**")
                            .font(.subheadline)
                    }
                    .accessibilityIdentifier("goToRegisterButton")

                    Spacer(minLength: 40)
                }
                .padding(.top, 48)
            }
            // tapping anywhere outside fields dismisses the keyboard
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
            .navigationDestination(isPresented: $showRegistration) {
                RegistrationView()
            }
            .navigationDestination(isPresented: $vm.isLoggedIn) {
                HomeView()
            }
        }
    }
}

#Preview {
    LoginView().environmentObject(AuthViewModel())
}
