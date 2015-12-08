//
//  CardDetailViewController.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    var card: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupCell(card: Card) {
        self.loadView()
        self.card = card
        cardImage.image = card.image
        self.navigationItem.title = "\(card.value) of \(card.suit.lowercaseString.capitalizedString)"
    }
    

    @IBOutlet weak var cardImage: UIImageView!
    
    
    
    
}
