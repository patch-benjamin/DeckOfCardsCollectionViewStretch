//
//  CardCollectionViewCell.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var card: Card?
    
    func setupCell(card: Card) {
        self.card = card
        cardImageView.image = card.image
    }
    
    @IBOutlet weak var cardImageView: UIImageView!
    
}
