//
//  DeckSuitTableViewCell.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class DeckSuitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var collectionView: deckSuitCollectionView!
    
}
