//
//  AuthViewModel.swift
//  LoginApp
//
//  Created by Andrew Reyna on 7/3/26.
//

//  MVVM ViewModel — owns all validation and auth logic.
//  Views bind to @Published properties and call methods here.
//
 
import Foundation
 
class AuthViewModel: ObservableObject {
 
    // MARK: - Login State
    @Published var loginEmail: String    = ""
    @Published var loginPassword: String = ""
    @Published var loginError: String    = ""
    @Published var isLoggedIn: Bool      = false
    @Published var loggedInUsername: String = ""
 
    // MARK: - Registration State
    @Published var regUsername: String        = ""
    @Published var regEmail: String           = ""
    @Published var regPassword: String        = ""
    @Published var regConfirmPassword: String = ""
    @Published var regError: String           = ""
    @Published var isRegistered: Bool         = false
 
    // MARK: - In-Memory User Store
    // Hardcoded default account + any accounts registered during the session
    private var users: [String: (username: String, password: String)] = [
        "student@test.com": (username: "Student", password: "Pass123")
    ]
 
    // MARK: - Validation Helpers
 
    /// Returns true when the email contains "@" and a "." after it
    func isValidEmail(_ email: String) -> Bool {
        let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard trimmed.contains("@") else { return false }
        let parts = trimmed.split(separator: "@")
        guard parts.count == 2, let domain = parts.last else { return false }
        return domain.contains(".")
    }
 
    /// At least 6 chars and contains at least one digit
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
 
        // Empty field check
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
 
        // Format validation
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
 
        // Save to in-memory store
        users[key] = (username: regUsername.trimmingCharacters(in: .whitespaces),
                      password: regPassword)
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
 
