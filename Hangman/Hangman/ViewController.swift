//
//  ViewController.swift
//  Hangman
//
//  Created by Daniel Hjärtström on 2017-07-22.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var drawingView: Hangman_View!
    @IBOutlet weak var wordView: UIView!
    @IBOutlet weak var guessingTextfield: UITextField!
    
    var characterViews: [UILabel] = []
    let words: [String] = ["Cat", "Dog", "Elephant", "Whisky", "Beer", "Wild", "Hell", "Monkey", "Intertrajectory", "Military", "Night", "Bunny", "Toys", "Mommy", "Sweden"]
    var wordInPlay: String = ""
    var charactersInWord: [String] = []
    var hangman: Hangman_View?
    var lives: Int = 8
    var livesLeft: Int = 0 {
    
        didSet {
        
            self.guessesLabel.text = "\(livesLeft) guesses left"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.layer.borderColor = UIColor.white.cgColor
        drawingView.layer.borderWidth = 2.0
        setupTextField()
        livesLeft = lives
    }
    
    func setupTextField(){

        guessingTextfield.delegate = self
        guessingTextfield.autocapitalizationType = .allCharacters
        guessingTextfield.font = UIFont(name: "Chalkboard SE", size: 17.0)
    
    }

    @IBAction func newWord(_ sender: UIButton) {
   
        reset()
   
        hangman = drawingView
        
        let randomNumber = random(upper: self.words.count)
        
        wordInPlay = words[randomNumber]
        
        charactersInWord = wordInPlay.characters.map { (String($0)) }
                
        createCharacterViews()
        
    }
    
    func reset(){

        for subview in wordView.subviews {
            subview.removeFromSuperview()
        }
        
        charactersInWord.removeAll()
        characterViews.removeAll()
        wordInPlay = ""
        self.livesLeft = lives
        
        if let hangmanView = hangman {
        
            hangmanView.reset()
            
        }
    }
    
    func createCharacterViews() {
        
        let labelWidth = wordView.frame.width / CGFloat(charactersInWord.count * 2)
        let labelHeight = wordView.frame.height / 2
        
        for i in (0..<charactersInWord.count) {
        
            let label = CharacterLabel(frame: CGRect(x: labelWidth * (CGFloat(i) + 0.5) + (CGFloat(i) * labelWidth), y: labelHeight - labelHeight / 2, width: labelWidth, height: labelHeight))
            
            characterViews.append(label)
            wordView.addSubview(characterViews[i])
            
        }
    }
    
    @IBAction func guessLetter(_ sender: UIButton) {
        
        guard let letter = self.guessingTextfield.text, !letter.isEmpty, !charactersInWord.isEmpty else {
            return
        }
        
        if arrayContainsString(array: charactersInWord, string: letter) {
            
            for (index, _) in charactersInWord.enumerated() {
                
                if  isCasinsensitiveCharacter(char: letter, equalTo: charactersInWord[index]){
                    
                    characterViews[index].text = letter
                
                }
            }
            
        } else {
            
            if let hangmanView = hangman {
            
                hangmanView.animate(number: self.lives - self.livesLeft)
                
            }
            
            self.livesLeft -= 1

        }
        
        self.guessingTextfield.text = ""
        
    }
    
    func isCasinsensitiveCharacter(char: String, equalTo: String) -> Bool {
        return char.caseInsensitiveCompare(equalTo) == .orderedSame
    }
    
    func arrayContainsString(array: [String], string: String) -> Bool {
        return array.contains( where: { $0.caseInsensitiveCompare(string) == .orderedSame } )
    }
    
    func random(upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper)))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let limit = 1
        
        let currentString: NSString = text as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string).uppercased() as NSString
        
        return newString.length <= limit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
