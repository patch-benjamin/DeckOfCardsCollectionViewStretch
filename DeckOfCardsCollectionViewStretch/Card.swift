//
//  Card.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class Card: NSObject {

    
    
    let image: UIImage
    let value: String
    let suit: String
    
    init(image: UIImage, value: String, suit: String) {
        
        self.image = image
        self.value = value
        self.suit = suit
        
    }
    
}
