//
//  CardController.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import Foundation

enum Suit: String {
    case Spades = "SPADES",
    Clubs = "CLUBS",
    Hearts = "HEARTS",
    Diamonds = "DIAMONDS"
}

class CardController {
    
    
    static func getCardsOfSuit(suit: Suit, deck: [Card]) -> [Card]{
        var deckOfSuit: [Card] = []
        switch suit {
        case .Clubs:
            deck.forEach({ (card) -> () in
                if card.suit == Suit.Clubs.rawValue {
                    deckOfSuit.append(card)
                }
            })
        case .Diamonds:
            deck.forEach({ (card) -> () in
                if card.suit == Suit.Diamonds.rawValue {
                    deckOfSuit.append(card)
                }
            })
        case .Hearts:
            deck.forEach({ (card) -> () in
                if card.suit == Suit.Hearts.rawValue {
                    deckOfSuit.append(card)
                }
            })
        case .Spades:
            deck.forEach({ (card) -> () in
                if card.suit == Suit.Spades.rawValue {
                    deckOfSuit.append(card)
                }
            })
        }
        return deckOfSuit
    }
    
    
    static func getDeckOfCards(completion: (deck: [Card], error: Bool) -> Void) {
        guard let url = NetworkController.URLForString()
            else { completion(deck: [], error: true); return }
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            if let resultData = resultData {
                
                let jsonObject: AnyObject
                
                do {
                    
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(resultData, options: [])
                    
                } catch(let error as NSError) {
                    print(error)
                    return
                }
                
                guard let searchableObject = jsonObject as? [String : AnyObject],
                    let cardDictionaries  = searchableObject["cards"] as? [[String : AnyObject]]
                    else { completion(deck: [], error: true); return }
                
                var cards: [Card] = []
                
                cardDictionaries.forEach({ (cardDictionary) -> () in
                    guard let imageString = cardDictionary["image"] as? String,
                        let value = cardDictionary["value"] as? String,
                        let suit = cardDictionary["suit"] as? String
                        else { completion(deck: [], error: true); return }
                    NetworkController.imageForImageURLString(imageString, completion: { (image, success) -> Void in
                        
                        if let image = image where success {
                            
                            cards.append(Card(image: image, value: value, suit: suit))
                            
                        } else {
                            print("No image found or success was failure: NetworkController.getDeckOfCards")
                        }
                    })
                })
                if cards.count == 52 {
                    completion(deck: cards, error: false)
                } else {
                    print("Not enough cards in the deck")
                    completion(deck: cards, error: true)
                }
            }
        }
    }

    
}