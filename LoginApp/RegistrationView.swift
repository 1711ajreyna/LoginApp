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
        VStack(spacing: 20) {

            // -- Header --
            Image(systemName: "person.badge.plus")
                .font(.system(size: 60))
                .foregroundStyle(.indigo)

            Text("Create Account")
                .font(.largeTitle.bold())

            // -- Fields --
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

                SecureField("Password", text: $vm.regPassword)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("regPasswordField")

                SecureField("Confirm Password", text: $vm.regConfirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("regConfirmPasswordField")
            }
            .padding(.horizontal)

            // -- Validation message --
            if !vm.regError.isEmpty {
                Text(vm.regError)
                    .foregroundStyle(.red)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .accessibilityIdentifier("regErrorLabel")
            }

            // -- Success message --
            if vm.isRegistered {
                Text("Account created! You can now log in.")
                    .foregroundStyle(.green)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .accessibilityIdentifier("regSuccessLabel")
            }

            // -- Register button --
            Button(action: { vm.register() }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.indigo)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            .accessibilityIdentifier("registerButton")

            // -- Back to login --
            Button(action: {
                vm.resetRegistration()
                dismiss()
            }) {
                Text("Already have an account? **Log In**")
                    .font(.subheadline)
            }
            .accessibilityIdentifier("backToLoginButton")

            Spacer()
        }
        .padding(.top, 32)
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RegistrationView().environmentObject(AuthViewModel())
    }
}
