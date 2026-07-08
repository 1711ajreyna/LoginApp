//
//  RegistrationView.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/3/26.
//


import SwiftUI

struct RegistrationView: View {

    @EnvironmentObject var vm: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Image(systemName: "person.badge.plus")
                    .font(.system(size: 60))
                    .foregroundStyle(.indigo)

                Text("Create Account")
                    .font(.largeTitle.bold())

                VStack(spacing: 14) {
                    TextField("Username", text: $vm.regUsername)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .accessibilityIdentifier("regUsernameField")

                    TextField("Email", text: $vm.regEmail)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .accessibilityIdentifier("regEmailField")

                    TextField("Password", text: $vm.regPassword)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .accessibilityIdentifier("regPasswordField")

                    TextField("Confirm Password", text: $vm.regConfirmPassword)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .accessibilityIdentifier("regConfirmPasswordField")
                }
                .padding(.horizontal)

                if !vm.regError.isEmpty {
                    Text(vm.regError)
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .accessibilityIdentifier("regErrorLabel")
                }

                if vm.isRegistered {
                    Text("Account created! You can now log in.")
                        .foregroundStyle(.green)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .accessibilityIdentifier("regSuccessLabel")
                }

                Button(action: {
                    vm.register()
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.indigo)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
                .accessibilityIdentifier("registerButton")

                Button(action: {
                    vm.resetRegistration()
                    dismiss()
                }) {
                    Text("Already have an account? **Log In**")
                        .font(.subheadline)
                }
                .accessibilityIdentifier("backToLoginButton")

                Spacer(minLength: 40)
            }
            .padding(.top, 32)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
