//
//  DeckOfCardsTableViewController.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class DeckOfCardsTableViewController: UITableViewController {

    
    var deck: [Card] = []
    
    var deckOfSuits: [[Card]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CardController.getDeckOfCards { (deck, error) -> Void in
            if !error && deck.count == 52 {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    // Setup deck
                    self.deck = deck
                    
                    // setup deckOfSuits
                    var deckOfSuits: [[Card]] = []
                    
                    deckOfSuits.append(CardController.getCardsOfSuit(Suit.Clubs, deck: self.deck))
                    deckOfSuits.append(CardController.getCardsOfSuit(Suit.Diamonds, deck: self.deck))
                    deckOfSuits.append(CardController.getCardsOfSuit(Suit.Hearts, deck: self.deck))
                    deckOfSuits.append(CardController.getCardsOfSuit(Suit.Spades, deck: self.deck))
                    
                    self.deckOfSuits = deckOfSuits
                    
                    // Reload the tableView
                    self.tableView?.reloadData()
                    
                })
            } else {
                
            }
        }
        
        self.navigationItem.title = "Deck Of Cards"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if deckOfSuits.count > 0 {
            // The number of Suits. Each Suit is it's own section in the TableView.
            return deckOfSuits.count
        } else {
            // display a loading statement in the header.
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deckOfSuits.count > 0 {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cardSuitCell", forIndexPath: indexPath) as! DeckSuitTableViewCell

        // Set the section property on the cell's collectionView for later reference when cell is selected.
        cell.collectionView.tableViewSection = indexPath.section
        
        return cell
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if deckOfSuits.count > 0 {
            // Set the header of each section to the Suit Name
            return deckOfSuits[section][0].suit
        } else {
            // display a loading title.
            return "LOADING..."
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToCardDetailView" {
            
            guard let detailViewController = segue.destinationViewController as? CardDetailViewController else { return }
            
            // The sender is a cell, so we can grab the cell, which a property of card.
            guard let cell = sender as? CardCollectionViewCell,
                let card = cell.card else { return }
            
            detailViewController.setupCell(card)
            
        }
    }
}




extension DeckOfCardsTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // want it to crash if failure. thus the !'s :
        // Cast the collectionView passed to this method as our own custom CollectionView class.
        let collectionView = collectionView as! deckSuitCollectionView
        // Get the section from the collectionView
        let tableViewSection = collectionView.tableViewSection!
        
        return deckOfSuits[tableViewSection].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Cast the collectionView passed to this method as our own custom CollectionView class.
        let collectionView = collectionView as! deckSuitCollectionView
        let tableViewSection = collectionView.tableViewSection! // want it to crash if nil
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.setupCell(deckOfSuits[tableViewSection][indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // Get the selected Cell use in the performSegue
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        performSegueWithIdentifier("ToCardDetailView", sender: cell!) // Make Cell the sender so we can get the Card associated with the selection
    }
    
}