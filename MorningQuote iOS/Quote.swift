//
//  Quote.swift
//  MorningQuote iOS
//
//  Created by Lucas Rollet on 05/12/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class Quote: NSObject, NSCoding {
    var quote: String
    var author: String
    var date: String
    
    init(quote: String, author: String, date: String) {
        self.quote = quote
        self.author = author
        self.date = date
    }
    
    required init(coder aDecoder: NSCoder) {
        quote = aDecoder.decodeObject(forKey: "quote") as! String
        author = aDecoder.decodeObject(forKey: "author") as! String
        date = aDecoder.decodeObject(forKey: "date") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(quote, forKey: "quote")
        aCoder.encode(author, forKey: "author")
        aCoder.encode(date, forKey: "date")
    }
}
