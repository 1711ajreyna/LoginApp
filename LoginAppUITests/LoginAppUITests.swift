//
//  LoginAppUITests.swift
//  LoginAppUITests
//
//  Created by Andrew Reyna on 7/3/26.
//


import XCTest

final class LoginAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // UI TEST 1 — Successful login navigates to the Home screen
    // Simulates a full login flow with valid credentials and verifies the
    // welcome label appears on the Home screen. This is the app's primary
    // happy-path — if it breaks, no user can access the app.
    
    func testSuccessfulLoginNavigatesToHomeScreen() {
        let emailField    = app.textFields["loginEmailField"]
        let passwordField = app.secureTextFields["loginPasswordField"]
        let loginButton   = app.buttons["loginButton"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("student@test.com")

        passwordField.tap()
        passwordField.typeText("Pass123")

        loginButton.tap()

        let welcomeLabel = app.staticTexts["welcomeLabel"]
        XCTAssertTrue(
            welcomeLabel.waitForExistence(timeout: 5),
            "Welcome label should appear after successful login"
        )
        XCTAssertEqual(welcomeLabel.label, "Welcome, Student!")
    }


    // UI TEST 2 — Wrong credentials show an error message
    // Verifies that entering an incorrect password displays the error label and
    // keeps the user on the login screen. This confirms the app blocks
    // unauthorized access and gives actionable feedback.

    func testInvalidCredentialsShowErrorMessage() {
        app.textFields["loginEmailField"].tap()
        app.textFields["loginEmailField"].typeText("student@test.com")

        app.secureTextFields["loginPasswordField"].tap()
        app.secureTextFields["loginPasswordField"].typeText("wrongpassword")

        app.buttons["loginButton"].tap()

        let errorLabel = app.staticTexts["loginErrorLabel"]
        XCTAssertTrue(
            errorLabel.waitForExistence(timeout: 5),
            "Error label should appear after failed login"
        )
        XCTAssertFalse(
            app.staticTexts["welcomeLabel"].exists,
            "Welcome label must not appear after failed login"
        )
    }

    // UI TEST 3 — Registration flow creates an account and shows success message
    // Simulates navigating to the Registration screen, filling all fields with
    // valid data, and tapping Register. Verifies the success label appears,
    // confirming the full registration UI flow works end-to-end.
    
    func testRegistrationFlowShowsSuccessMessage() {
        // Navigate to Registration
        let goToRegister = app.buttons["goToRegisterButton"]
        XCTAssertTrue(goToRegister.waitForExistence(timeout: 5))
        goToRegister.tap()

        // Fill in all fields
        let usernameField = app.textFields["regUsernameField"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 5))
        usernameField.tap()
        usernameField.typeText("NewStudent")

        app.textFields["regEmailField"].tap()
        app.textFields["regEmailField"].typeText("newstudent@test.com")

        app.secureTextFields["regPasswordField"].tap()
        app.secureTextFields["regPasswordField"].typeText("Hello123")

        app.secureTextFields["regConfirmPasswordField"].tap()
        app.secureTextFields["regConfirmPasswordField"].typeText("Hello123")

        app.buttons["registerButton"].tap()

        // Success label must appear
        let successLabel = app.staticTexts["regSuccessLabel"]
        XCTAssertTrue(
            successLabel.waitForExistence(timeout: 5),
            "Success label should appear after valid registration"
        )
    }

    // UI TEST 4 — Mismatched passwords show a validation error on registration
    // Verifies that entering two different passwords on the Registration screen
    // displays the error label rather than creating an account. This protects
    // users from locking themselves out with an unintended password.

    func testRegistrationPasswordMismatchShowsError() {
        app.buttons["goToRegisterButton"].tap()

        let usernameField = app.textFields["regUsernameField"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 5))
        usernameField.tap()
        usernameField.typeText("Alice")

        app.textFields["regEmailField"].tap()
        app.textFields["regEmailField"].typeText("alice@test.com")

        app.secureTextFields["regPasswordField"].tap()
        app.secureTextFields["regPasswordField"].typeText("Pass123")

        app.secureTextFields["regConfirmPasswordField"].tap()
        app.secureTextFields["regConfirmPasswordField"].typeText("Pass999")

        app.buttons["registerButton"].tap()

        let errorLabel = app.staticTexts["regErrorLabel"]
        XCTAssertTrue(
            errorLabel.waitForExistence(timeout: 5),
            "Error label should appear when passwords do not match"
        )
        XCTAssertFalse(
            app.staticTexts["regSuccessLabel"].exists,
            "Success label must not appear after a failed registration"
        )
    }

    
    // UI TEST 5 — Logout from Home screen returns to Login screen
    // Verifies that tapping Log Out on the Home screen brings the user back to
    // the login screen. This ensures the session management flow works and
    // users can securely end their session.
    
    func testLogoutReturnsToLoginScreen() {
        // Log in first
        app.textFields["loginEmailField"].tap()
        app.textFields["loginEmailField"].typeText("student@test.com")
        app.secureTextFields["loginPasswordField"].tap()
        app.secureTextFields["loginPasswordField"].typeText("Pass123")
        app.buttons["loginButton"].tap()

        // Wait for home screen
        let logoutButton = app.buttons["logoutButton"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 5))
        logoutButton.tap()

        // Login screen must reappear
        XCTAssertTrue(
            app.textFields["loginEmailField"].waitForExistence(timeout: 5),
            "Login email field should reappear after logout"
        )
        XCTAssertFalse(
            app.staticTexts["welcomeLabel"].exists,
            "Welcome label must not be visible after logout"
        )
    }
}
