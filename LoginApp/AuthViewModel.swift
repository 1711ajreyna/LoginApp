//
//  AuthViewModel.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/3/26.
//

//
//  AuthViewModel.swift
//  LoginApp
//

import Foundation

class AuthViewModel: ObservableObject {

    // MARK: - Login State
    @Published var loginEmail: String       = ""
    @Published var loginPassword: String    = ""
    @Published var loginError: String       = ""
    @Published var isLoggedIn: Bool         = false
    @Published var loggedInUsername: String = ""

    // MARK: - Registration State
    @Published var regUsername: String        = ""
    @Published var regEmail: String           = ""
    @Published var regPassword: String        = ""
    @Published var regConfirmPassword: String = ""
    @Published var regError: String           = ""
    @Published var isRegistered: Bool         = false

    // MARK: - User Store
    // Now uses the User model instead of a raw tuple dictionary
    private var users: [String: User] = [
        "student@test.com": User(
            username: "Student",
            email: "student@test.com",
            password: "Pass123"
        )
    ]

    // MARK: - Validation

    func isValidEmail(_ email: String) -> Bool {
        let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard trimmed.contains("@") else { return false }
        let parts = trimmed.split(separator: "@")
        guard parts.count == 2, let domain = parts.last else { return false }
        return domain.contains(".")
    }

    func isValidPassword(_ password: String) -> Bool {
        guard password.count >= 6 else { return false }
        return password.contains(where: { $0.isNumber })
    }

    // MARK: - Login

    func login() {
        loginError = ""

        guard !loginEmail.trimmingCharacters(in: .whitespaces).isEmpty,
              !loginPassword.isEmpty else {
            loginError = "Email and password are required."
            return
        }

        guard isValidEmail(loginEmail) else {
            loginError = "Please enter a valid email address."
            return
        }

        let key = loginEmail.trimmingCharacters(in: .whitespaces).lowercased()

        guard let user = users[key] else {
            loginError = "No account found for that email."
            return
        }

        guard user.password == loginPassword else {
            loginError = "Incorrect password. Please try again."
            return
        }

        loggedInUsername = user.username
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn       = false
        loggedInUsername = ""
        loginEmail       = ""
        loginPassword    = ""
        loginError       = ""
    }

    // MARK: - Registration

    func register() {
        regError = ""

        guard !regUsername.trimmingCharacters(in: .whitespaces).isEmpty else {
            regError = "Username is required."; return
        }
        guard !regEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            regError = "Email is required."; return
        }
        guard !regPassword.isEmpty else {
            regError = "Password is required."; return
        }
        guard !regConfirmPassword.isEmpty else {
            regError = "Please confirm your password."; return
        }
        guard isValidEmail(regEmail) else {
            regError = "Please enter a valid email address."; return
        }
        guard isValidPassword(regPassword) else {
            regError = "Password must be at least 6 characters and contain a number."; return
        }
        guard regPassword == regConfirmPassword else {
            regError = "Passwords do not match."; return
        }

        let key = regEmail.trimmingCharacters(in: .whitespaces).lowercased()

        guard users[key] == nil else {
            regError = "An account with that email already exists."; return
        }

        // Now creates a proper User model and saves it
        let newUser = User(
            username: regUsername.trimmingCharacters(in: .whitespaces),
            email: key,
            password: regPassword
        )
        users[key] = newUser
        isRegistered = true
    }

    func resetRegistration() {
        regUsername        = ""
        regEmail           = ""
        regPassword        = ""
        regConfirmPassword = ""
        regError           = ""
        isRegistered       = false
    }
}
