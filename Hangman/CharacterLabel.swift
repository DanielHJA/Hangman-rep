//
//  CharacterLabel.swift
//  Hangman
//
//  Created by Daniel Hjärtström on 2017-07-24.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CharacterLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.font = UIFont(name: "ChalkboardSE-Bold", size: 19.0)
        self.minimumScaleFactor = 0.3
        self.adjustsFontSizeToFitWidth = true
        
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.black.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1.0)
        self.layer.addSublayer(bottomBorder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}
