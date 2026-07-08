//
//  LoginAppUITests.swift
//  LoginAppUITests
//
//  Created by Andrew Reyna on 7/3/26.
//
//  Tests Included:
//  1. Successful Login
//  2. Invalid Login
//  3. Successful Registration
//  4. Registration Password Mismatch
//  5. Logout
//

import XCTest

final class LoginAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSuccessfulLoginNavigatesToHome() {
        let email = app.textFields["loginEmailField"]
        XCTAssertTrue(email.waitForExistence(timeout: 5))
        email.tap()
        email.typeText("student@test.com")

        let password = app.secureTextFields["loginPasswordField"]
        XCTAssertTrue(password.waitForExistence(timeout: 5))
        password.tap()
        password.typeText("Pass123")

        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.staticTexts["welcomeLabel"].waitForExistence(timeout: 5))
    }

    func testInvalidCredentialsShowError() {
        let email = app.textFields["loginEmailField"]
        XCTAssertTrue(email.waitForExistence(timeout: 5))
        email.tap()
        email.typeText("wrong@test.com")

        let password = app.secureTextFields["loginPasswordField"]
        XCTAssertTrue(password.waitForExistence(timeout: 5))
        password.tap()
        password.typeText("Wrong123")

        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.staticTexts["loginErrorLabel"].waitForExistence(timeout: 5))
    }

    func testRegistrationFlowShowsSuccessMessage() {
        let goToRegister = app.buttons["goToRegisterButton"]
        XCTAssertTrue(goToRegister.waitForExistence(timeout: 5))
        goToRegister.tap()

        let username = app.textFields["regUsernameField"]
        XCTAssertTrue(username.waitForExistence(timeout: 5))
        username.tap()
        username.typeText("NewStudent")

        let email = app.textFields["regEmailField"]
        XCTAssertTrue(email.waitForExistence(timeout: 5))
        email.tap()
        email.typeText("newstudent@test.com")

        let password = app.textFields["regPasswordField"]
        XCTAssertTrue(password.waitForExistence(timeout: 5))
        password.tap()
        password.typeText("Password123")

        let confirm = app.textFields["regConfirmPasswordField"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 5))
        confirm.tap()
        confirm.typeText("Password123")

        app.swipeUp()

        let registerButton = app.buttons["registerButton"]
        XCTAssertTrue(registerButton.waitForExistence(timeout: 5))
        registerButton.tap()

        if app.staticTexts["regErrorLabel"].exists {
            XCTFail("Registration Error: \(app.staticTexts["regErrorLabel"].label)")
        }

        let success = app.staticTexts["regSuccessLabel"]
        XCTAssertTrue(success.waitForExistence(timeout: 5))
    }

    func testRegistrationPasswordMismatchShowsError() {
        let goToRegister = app.buttons["goToRegisterButton"]
        XCTAssertTrue(goToRegister.waitForExistence(timeout: 5))
        goToRegister.tap()

        let username = app.textFields["regUsernameField"]
        XCTAssertTrue(username.waitForExistence(timeout: 5))
        username.tap()
        username.typeText("Andrew")

        let email = app.textFields["regEmailField"]
        XCTAssertTrue(email.waitForExistence(timeout: 5))
        email.tap()
        email.typeText("andrew@test.com")

        let password = app.textFields["regPasswordField"]
        XCTAssertTrue(password.waitForExistence(timeout: 5))
        password.tap()
        password.typeText("Password123")

        let confirm = app.textFields["regConfirmPasswordField"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 5))
        confirm.tap()
        confirm.typeText("WrongPassword1")

        app.swipeUp()

        let registerButton = app.buttons["registerButton"]
        XCTAssertTrue(registerButton.waitForExistence(timeout: 5))
        registerButton.tap()

        XCTAssertTrue(app.staticTexts["regErrorLabel"].waitForExistence(timeout: 5))
    }

    func testLogoutReturnsToLoginScreen() {
        let email = app.textFields["loginEmailField"]
        XCTAssertTrue(email.waitForExistence(timeout: 5))
        email.tap()
        email.typeText("student@test.com")

        let password = app.secureTextFields["loginPasswordField"]
        XCTAssertTrue(password.waitForExistence(timeout: 5))
        password.tap()
        password.typeText("Pass123")

        app.buttons["loginButton"].tap()

        let logout = app.buttons["logoutButton"]
        XCTAssertTrue(logout.waitForExistence(timeout: 5))
        logout.tap()

        XCTAssertTrue(app.buttons["loginButton"].waitForExistence(timeout: 5))
    }
}
