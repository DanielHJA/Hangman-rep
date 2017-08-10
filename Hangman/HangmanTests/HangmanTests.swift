//
//  HangmanTests.swift
//  HangmanTests
//
//  Created by Daniel Hjärtström on 2017-07-22.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import XCTest
@testable import Hangman

class HangmanTests: XCTestCase {
    
    var testVc: ViewController!
    let testWord = "Minnesota"

    override func setUp() {
        super.setUp()

        //get the storyboard the ViewController under test is inside
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        testVc = storyboard.instantiateViewController(withIdentifier: "MyViewController") as! ViewController
        
        //load view hierarchy
        if(testVc != nil) {
            
            testVc.loadView()
            testVc.viewDidLoad()
        }
    }
    
    override func tearDown() {

        testVc = nil
        
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit() {
    
        XCTAssertNotNil(testVc.drawingView, "We have a drawing view")
        XCTAssertEqual(testVc.wordInPlay, "", "Word is nil")
        XCTAssertEqual(testVc.charactersInWord.count, 0, "charactersInWords nil")
        XCTAssertEqual(testVc.characterViews.count, 0, "CharatcterViews nil")
        XCTAssertEqual(testVc.lives, 8, "Wrong number of lives")
        XCTAssertGreaterThan(testVc.words.count, 0, "There are no words to play with")
    
    }
    
    func testNewWord() {
        
        testVc.setupWord(word: testWord)
        
        XCTAssertGreaterThan(testVc.wordInPlay.characters.count, 1, "There is no word in play")
        XCTAssertEqual(testVc.charactersInWord.count, testWord.characters.count, "Word count does not matching number of characters")
    
    }
    
    func testWrongGuess() {
    
        testVc.livesLeft = 8
        testVc.setupWord(word: testWord)
        testVc.userDidGuess(letter: "q")
        XCTAssertEqual(testVc.livesLeft, 7, "Wrong number of lives")
        
        
    }
    
    func testHangman() {
    
        let hangman = Hangman_View()
 
        XCTAssert(hangman.layers.count == 0, "Clear")
        XCTAssert(hangman.paths.count == 0, "Clear")
        
        hangman.animate(number: 0)
        
        XCTAssert(hangman.layers.count != 0, "Clear")
        XCTAssert(hangman.paths.count != 0, "Clear")
        
    
    }
}
