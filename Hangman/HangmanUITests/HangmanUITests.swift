//
//  HangmanUITests.swift
//  HangmanUITests
//
//  Created by Daniel Hjärtström on 2017-07-22.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import XCTest
@testable import Hangman

class HangmanUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMyTest() {
    
        
        let app = XCUIApplication()
        let textField = app.textFields["guessingTextField"]
        
        textField.tap()
        textField.typeText("K")
        
        let guessButton = app.buttons["Guess"]
        guessButton.tap()
        app.keys["Y"].tap()
        textField.typeText("U")
        guessButton.tap()
        app.keys["O"].tap()
        textField.typeText("O")
        guessButton.tap()
        app.keys["N"].tap()
        textField.typeText("N")
        guessButton.tap()
        app.keys["M"].tap()
        textField.typeText("M")
        guessButton.tap()
        app.keys["I"].tap()
        textField.typeText("I")
        guessButton.tap()
        app.keys["E"].tap()
        textField.typeText("E")
        guessButton.tap()
        app.keys["Q"].tap()
        textField.typeText("Q")
        guessButton.tap()
        app.keys["R"].tap()
        textField.typeText("R")
        guessButton.tap()
        app.keys["P"].tap()
        textField.typeText("P")
        guessButton.tap()
        textField.typeText("K")
        guessButton.tap()
        app.keys["B"].tap()
        textField.typeText("B")
        guessButton.tap()
        app.keys["T"].tap()
        textField.typeText("T")
        guessButton.tap()
        app.keys["D"].tap()
        textField.typeText("D")
        guessButton.tap()
        app.buttons["New Word"].tap()

        
    }
    
}
