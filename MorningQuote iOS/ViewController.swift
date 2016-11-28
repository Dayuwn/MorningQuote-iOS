//
//  ViewController.swift
//  MorningQuote iOS
//
//  Created by Lucas Rollet on 27/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    // MARK : Outlet vars
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberOfFavsLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var quoteBackgroundView: UIView!
    
    // MARK : Logic & Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.isNavigationBarHidden = true
        
        pickQuote()
    }
    
    func pickQuote() {
        if true { // Pick a downloaded quote if couldn't connext to Internet.
            // TODO : Show an alert to maje the user connect to WiFi network
            let quotes = LocalQuotes.quotes
            let quote: [String: String] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: quotes)[0] as! [String: String]
            
            quoteLabel.text = quote["quote"]
            authorLabel.text = quote["author"]
        }
        else {
            
        }
    }

    // MARK : Bottom bar actions outlets
    
    @IBAction func addToFavorites(_ sender: UIButton) {
    
    }
    
    @IBAction func showFavorites(_ sender: UIButton) {
    
    }
    
    @IBAction func shareItem(_ sender: UIButton) {
    
    }
}

