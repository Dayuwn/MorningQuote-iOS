//
//  ViewController.swift
//  MorningQuote iOS
//
//  Created by Lucas Rollet on 27/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit
import Social
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
    
    // MARK : Data Vars
    
    var quoteObj: Quote! = nil
    var favQuotes = [Quote]()
    
    // MARK : Consts / Keys
    
    let DEFAULTS_FAV_KEY = "favQuotes"
    
    // MARK : Logic & Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.isNavigationBarHidden = true
        
        getQuote()
        getFavQuotes()
    }
    
    // Gets and parses the quote from external server.
    func getQuote() {
        let quotesApiUrlString = "https://evening-bayou-67567.herokuapp.com/api/morning-quote/?format=json"
        
        // Gets the quote and parses it from the backend server.
        if let url = URL(string: quotesApiUrlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json.arrayValue != [] {
                    for value in json.arrayValue {
                        let quote = value["quote"].stringValue
                        let author = value["author"].stringValue
                        let date = value["date"].stringValue
                        
                        quoteObj = Quote(quote: quote, author: author, date: date)
                        
                        quoteLabel.text = quoteObj.quote
                        authorLabel.text = quoteObj.author
                    }
                    // TODO : Change the image too.
                    return
                        
                }
            }
        }
        
        // If the data fetching wen't wrong gets a quote saved locally.
        let quotes = LocalQuotes.quotes
        let quote: [String: String] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: quotes)[0] as! [String: String]
        
        quoteLabel.text = quote["quote"]
        authorLabel.text = quote["author"]
    }
    
    // Gets the user's favorites quotes form NSArchiver.
    func getFavQuotes() {
        let defaults = UserDefaults.standard
        if let savedFavs = defaults.object(forKey: DEFAULTS_FAV_KEY) as? Data {
            favQuotes = NSKeyedUnarchiver.unarchiveObject(with: savedFavs) as! [Quote]
        }
    }

    // MARK : Bottom bar actions outlets
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        favQuotes.append(quoteObj)
        let savedData = NSKeyedArchiver.archivedData(withRootObject: favQuotes)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: DEFAULTS_FAV_KEY);
    }
    
    @IBAction func showFavorites(_ sender: UIButton) {
        let vc = FavoritesTableViewController()
        vc.quotes = favQuotes
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareItem(_ sender: UIButton) {
        let vc = UIActivityViewController(activityItems: [quoteObj.quote = " - " + quoteObj.author], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

