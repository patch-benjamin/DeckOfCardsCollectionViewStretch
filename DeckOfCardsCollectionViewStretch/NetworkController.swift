//
//  NetworkController.swift
//  DeckOfCardsCollectionViewStretch
//
//  Created by Benjamin Patch on 12/8/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

class NetworkController {
    
    static let baseURLString = "http://deckofcardsapi.com/api/deck/new/draw/?count=52"
    
    static func URLForString(urlString: String = baseURLString) -> NSURL? {
        guard let url = NSURL(string: urlString)
            else { print("Faulty URLString. No Valid URL."); return nil }
        
        return url
    }

    static func imageForImageURLString(imageURLString: String, completion: (image: UIImage?, success: Bool) -> Void) {
        guard let url = NSURL(string: imageURLString),
            let data = NSData(contentsOfURL: url),
            let image = UIImage(data: data)
            else { completion(image: nil, success: false); return }
        
        completion(image: image, success: true)
    }
    
    static func dataAtURL (url: NSURL, completion: (resultData: NSData?) -> Void){
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            
            if let error = error {
                
                print("\(error.localizedDescription)")
                
            }
            
            completion(resultData: data)
            
        }
        
        dataTask.resume()
        
    }

}













