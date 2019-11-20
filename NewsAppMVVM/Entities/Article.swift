//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article: NSObject {
    var articleTitle : String = ""
    var articleDescription: String = ""
    var articleContent : String = ""
    var articleAuthor : String = ""
    var articleDate : Date = Date()
    var articleSource : String = ""
    var articleURL : String = ""
    var imageURL : String = ""
    var isFavourited: Bool = false
    
    init(articlesJSON : JSON) {
        articleTitle = articlesJSON["title"].string!
        articleDescription = articlesJSON["description"].string ?? "Description not available"
        articleContent = articlesJSON["content"].string ?? "No article content available in the app, you can read the full article here ->"
        articleAuthor = articlesJSON["author"].string ?? "Anonymous"
        articleDate = Article.convertDateToNormalDate(dateToConvert: articlesJSON["publishedAt"].string!)
        articleSource = articlesJSON["source"]["name"].string ?? "Unknown"
        articleURL = articlesJSON["url"].string!
        imageURL = articlesJSON["urlToImage"].string ?? "No image available"
    }
    
    static func convertDateToNormalDate(dateToConvert: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertedDate = format.date(from: dateToConvert)
        return convertedDate ?? Date()
    }
}
